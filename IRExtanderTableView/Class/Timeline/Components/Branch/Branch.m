//
//  Branch.m
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "Branch.h"
#import "FunctionModelItem.h"
#import "FunctionModelBranchItem.h"
#import "FunctionModelLeafItem.h"
#import "BranchTableViewCell.h"
#import "LeafTableViewCell.h"
#import "BranchHeaderView.h"
#import "BranchFooterView.h"
#import "UIColor+Helper.h"
#import "Leaf.h"

@interface Branch()<UITableViewDelegate, DeviceDetailHeaderViewDelegate>
@end

@implementation Branch {
    NSMutableSet *loadeds;
}

@synthesize superNode;
@synthesize session;

- (instancetype)init {
    if(self = [super init]){
        children = [NSMutableArray array];
        model = [[Model alloc] initWithTableView:nil];
        [model updateWithData:self.session];
        model.delegate = self;
        self.isOpened = YES;
    }
    
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if(self = [self init]){
        self.tableView = (BranchTableIView *)tableView;
    }
    
    return self;
}

- (instancetype)initWithData:(Session *)session {
    self = [self init];
    if (self) {
        self.session = session;
    }
    return self;
}

- (void)setTableView:(BranchTableIView *)tableView {
    _tableView = tableView;
    self.tableView.dataSource = model;
    self.tableView.delegate = self;
    [model regeisterWithTableView:tableView];
    [self.tableView registerNib:[UINib nibWithNibName:[BranchFooterView identifier] bundle:nil] forHeaderFooterViewReuseIdentifier:[BranchFooterView identifier]];
    loadeds = [NSMutableSet set];
//    self.isOpened = self.isOpened;
}

- (void)attachWithTableView:(BranchTableIView*)tableView withIndex:(NSInteger)index {
    Branch *branch = [children objectAtIndex:index];

    if(branch.tableView && branch.tableView != tableView){
        
        branch.isNeedReload = YES;
    }
    
    if(tableView.bindedBranch && tableView.bindedBranch != branch){
        tableView.bindedBranch.isNeedReload = YES;
    }
    
    tableView.bindedBranch = branch;
    branch.tableView = tableView;
}

- (void)reloadwithIndex:(NSInteger)index {
    Branch *branch = [children objectAtIndex:index];

    [UIView setAnimationsEnabled:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [branch.tableView performBatchUpdates:^{

        } completion:^(BOOL finished) {

            BOOL needLoopUpdate = YES;
            for (id<Corp> child in branch.getChildren) {
                if([child isKindOfClass:[Branch class]] && !((Branch*)child).isOpened){
                    needLoopUpdate = NO;
                }
            }

            if(needLoopUpdate){
                [self loopUpdate:self];
            }

        }];
    });
    [UIView setAnimationsEnabled:YES];
}

- (void)reload {
    [self.tableView reloadDataWithCompletion:^{
        BOOL needLoopUpdate = YES;
        for (id<Corp> child in self.getChildren) {
            if([child isKindOfClass:[Branch class]] && !((Branch*)child).isOpened){
                needLoopUpdate = NO;
            }
        }

        if(needLoopUpdate){
            [self loopUpdate];
        }
    }];
}

- (void)hide:(NSInteger)section {
    Branch *branch = [children objectAtIndex:section];
    [branch click];
    
    [UIView setAnimationsEnabled:NO];
    
    [branch.tableView performBatchUpdates:^{
        [branch->model hideAll:branch.tableView];
    } completion:^(BOOL finished) {
        [branch.tableView setNeedsUpdateConstraints];
        [branch.tableView needsUpdateConstraints];
        [branch.tableView setNeedsLayout];
        [branch.tableView layoutIfNeeded];
        [branch.tableView.superview setNeedsLayout];
        [branch.tableView.superview layoutIfNeeded];
        
        [self loopUpdate:branch];
    }];

    [UIView setAnimationsEnabled:YES];

    
}

- (void)loopUpdate {
    if(self.superNode){
        [self.superNode loopUpdate:self];
    } else {
        [self loopUpdate:self];
    }
}

- (void)add:(id<Corp>)corp {
    if(corp.superNode){
        [corp.superNode remove:corp];
    }
    [children addObject:corp];
    corp.superNode = self;
    
    if (!corp.session) {
        corp.session = self.session;
    }
    
    if([corp isKindOfClass:[Branch class]]){
//        ((Branch*)corp).isOpened = ((Branch*)corp).isOpened;
        FunctionModelBranchItem *branchItem = [[FunctionModelBranchItem alloc] initWithRowCount:1];
        [branchItem updateWithData:corp.session];
        [model addItem:branchItem];
    }else{
//        ((Leaf*)corp).isOpened = ((Leaf*)corp).isOpened;
        FunctionModelLeafItem *leafItem = [[FunctionModelLeafItem alloc] initWithRowCount:1];
        [leafItem updateWithData:corp.session];
        [model addItem:leafItem];
    }
}

- (void)remove:(id<Corp>)corp {
    if([children containsObject:corp]){
        NSInteger index = [children indexOfObject:corp];
        [children removeObject:corp];
        corp.superNode = nil;
        [model removeItemAtIndex:index];
    }
}

- (NSArray *)getChildren {
    return children;
}

- (void)click {
    self.isOpened = !self.isOpened;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(![model getSectionTitleinSection:section]){
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if([self tableView:tableView heightForHeaderInSection:section] == 0) {
        return nil;
    }
    
    BranchHeaderView* sectionHeaderView = (BranchHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BranchHeaderView"];
    sectionHeaderView.delegate = self;
    
    Branch *branch = [self->children objectAtIndex:section];
    UIColor *backgroundColor = nil;
    if (branch.isOpened) {
        backgroundColor = [UIColor colorWithColorCodeString:openedBackgroundColor];
    } else {
        backgroundColor = [UIColor colorWithColorCodeString:closedBackgroundColor];
    }
    
    sectionHeaderView.roundCornerView.backgroundColor = backgroundColor;
    sectionHeaderView.lineImageView.backgroundColor = backgroundColor;
    
    sectionHeaderView.titleLabel.text = [model getSectionTitleinSection:section];
    sectionHeaderView.titleLabel.textColor = [model hiddenRowsinSection:section] ? [UIColor colorWithColorCodeString:closedTextColor] : [UIColor colorWithColorCodeString:openedTextColor];
    sectionHeaderView.lineImageView.hidden = !branch.isOpened && (section == [model numberOfSectionsInTableView:tableView] - 1);
    sectionHeaderView.tag = section;
    sectionHeaderView.arrowImageView.highlighted = ![model hiddenRowsinSection:section];
    
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if([self->model hiddenRowsinSection:section])
        return nil;
    if([self tableView:tableView heightForFooterInSection:section] == 0) {
        return nil;
    }
        
    BranchFooterView* sectionFooterView = (BranchFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[BranchFooterView identifier]];
    
    id<FunctionModelItem> item = [model getIteminSection:section];
    Session *session = ((FunctionModelBranchItem *)item).session;
    
    sectionFooterView.timeLabel.text = session.displayDisTime;
    sectionFooterView.titleLabel.text = session.reason;
    sectionFooterView.leaveLabel.text = session.leave;
    
    sectionFooterView.tag = section;
    
    return sectionFooterView;
}

#pragma mark - DeviceDetailHeaderViewDelegate
- (void)didClickAccessButtonInSection:(NSInteger)section {
    [self performBranchClickAtSections:@[@(section)]];
}

- (void)performBranchClickAtSections:(NSArray<NSNumber *> *)sections {
    [self loopWillUpdate];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSNumber *sectionNumber in sections) {
            NSInteger section = [sectionNumber integerValue];
            Branch *branch = [self->children objectAtIndex:section];
            [branch click];
        }

        [self updateTableViewUIWithSections:sections];
    });
}

- (void)updateTableViewUIWithSections:(NSArray<NSNumber *> *)sections {
    dispatch_async(dispatch_get_main_queue(), ^{
    [UIView setAnimationsEnabled:NO];
        [self.tableView performBatchUpdates:^{
            NSMutableIndexSet *sectionsSet = [NSMutableIndexSet indexSet];
            NSMutableArray *indexPathsForDelete = [NSMutableArray array];
            NSMutableArray *indexPathsForInsert = [NSMutableArray array];
            for (NSNumber *sectionNumber in sections) {
                NSInteger section = [sectionNumber integerValue];
                [sectionsSet addIndex:section];
                
                Branch *branch = [self->children objectAtIndex:section];
                [self->model hideRows:!branch.isOpened inSection:section];
                
                if([self->model hiddenRowsinSection:section])
                    [indexPathsForDelete addObject:[NSIndexPath indexPathForRow:0 inSection:section]];
                else
                    [indexPathsForInsert addObject:[NSIndexPath indexPathForRow:0 inSection:section]];
            }
            
            if(indexPathsForDelete.count > 0){
                [self.tableView deleteRowsAtIndexPaths:indexPathsForDelete withRowAnimation:UITableViewRowAnimationNone];
            }
            if(indexPathsForInsert.count > 0){
                [self.tableView insertRowsAtIndexPaths:indexPathsForInsert withRowAnimation:UITableViewRowAnimationNone];
            }
            
            [self.tableView reloadSections:sectionsSet withRowAnimation:UITableViewRowAnimationNone];
        } completion:^(BOOL finished) {
            if(self.superNode){
                [self.superNode loopUpdate:self];
            } else {
                [self.delegate didUpdate:nil];
            }
        }];
    [UIView setAnimationsEnabled:YES];
    });
}

- (void)loopWillUpdate {
    [self.delegate willUpdate:nil];
    
    if(self.superNode){
        [self.superNode loopWillUpdate];
    }
}

- (void)loopUpdate:(id<Corp>)calledChild {
    [UIView setAnimationsEnabled:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView performBatchUpdates:^{

        } completion:^(BOOL finished) {
            
            if(self.superNode){
                [self.superNode loopUpdate:self];
            } else {
                [self.delegate didUpdate:nil];
            }
        }];
    });
    [UIView setAnimationsEnabled:YES];
}


- (void)setIsOpened:(BOOL)isOpened {
    if(_isOpened == isOpened)
        return;
    
    _isOpened = isOpened;
    if (superNode) {
        [((Branch*)superNode)->model hideRows:!_isOpened inSection:[((Branch*)superNode)->children indexOfObject:self]];
    }
}

- (void)hideSectionWithChild:(id<Corp>)child hide:(BOOL)hide {
    [self->model hideRows:hide inSection:[self->children indexOfObject:child]];
}

@end
