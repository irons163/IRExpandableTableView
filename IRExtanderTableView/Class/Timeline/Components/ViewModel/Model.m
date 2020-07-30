//
//  Model.m
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "Model.h"
#import "FunctionModelBranchItem.h"
#import "BranchTableViewCell.h"
#import "LeafTableViewCell.h"

@interface Model(Protected)

- (void)initItemsAddToArray:(NSMutableArray<FunctionModelItem>*)items;

@end

@interface Model()<BranchTableViewCellDelegate>
@end

@implementation Model {
    
}

- (instancetype)initWithTableView:(UITableView*)tableView {
    if (self = [super init]) {
        items = [[NSMutableArray<FunctionModelItem> alloc] init];
        [self regeisterWithTableView:tableView];
        cells = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)regeisterWithTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:BranchTableViewCell.identifier bundle:nil] forCellReuseIdentifier:BranchTableViewCell.identifier];
    [tableView registerNib:[UINib nibWithNibName:LeafTableViewCell.identifier bundle:nil] forCellReuseIdentifier:LeafTableViewCell.identifier];
}

- (void)updateWithData:(Session *)session {
    _session = session;
}

- (void)addItem:(id<FunctionModelItem>)item {
    [items addObject:item];
}

- (void)removeItemAtIndex:(NSInteger)index {
    [items removeObjectAtIndex:index];
}

- (NSString*)getSectionTitleinSection:(NSInteger)section {
    return [items[section] sectionTitle];
}

- (UIImage*)getSectionLeftIconinSection:(NSInteger)section {
    return [items[section] sectionLeftIcon];
}

- (FunctionType)getFunctionTypeinSection:(NSInteger)section {
    return [(id<FunctionModelItem>)items[section] type];
}

- (id<FunctionModelItem>)getIteminSection:(NSInteger)section {
    return (id<FunctionModelItem>)items[section];
}

- (void)hideRows:(BOOL)hide inSection:(NSInteger)section {
    [items[section] setHideCells:hide];
}

- (BOOL)hiddenRowsinSection:(NSInteger)section {
    return [items[section] hideCells];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return items.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items[section] rowCount];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id<FunctionModelItem> item = [items objectAtIndex:indexPath.section];
    switch (item.type) {
        case BRANCH:
        {
            BranchTableViewCell *cell = (BranchTableViewCell *)[cells objectForKey:indexPath];
            if(!cell) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:BranchTableViewCell.identifier owner:self options:nil];
                cell = (BranchTableViewCell *)[nib objectAtIndex:0];
                [cells setObject:cell forKey:indexPath];
                [self.delegate attachWithTableView:cell.tableView withIndex:indexPath.section];
                [self.delegate reloadwithIndex:indexPath.section];
            }
            if(cell){
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tag = indexPath.section;
                cell.delegate = self;
                
                UIImage *_iconImage = [UIImage imageNamed:@"ban"];
                item.session.iconImage = _iconImage;
                
                
                [cell layoutIfNeeded];
                return cell;
            }
        }
        case LEAF:
        {
            LeafTableViewCell* cell =
            (LeafTableViewCell*)[tableView dequeueReusableCellWithIdentifier:LeafTableViewCell.identifier forIndexPath:indexPath];
            if(cell){
                cell.nameLabel.text = [item rowTitleForIndex:indexPath.row];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }
        default:
            break;
    }
    return [[UITableViewCell alloc] init];
}

- (void)hideAll:(UITableView *)tableView {
    
    for(int section = 0; section < [items count]; section++){
        [self hideRows:![self hiddenRowsinSection:section] inSection:section];
        
        if([self hiddenRowsinSection:section]){
            [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)loadAll:(UITableView *)tableView {
    for(int section = 0; section < [tableView numberOfSections]; section++){
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    for(int section = 0; section < [items count]; section++){
        [tableView insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (NSInteger)getCountOfItems {
    return items.count;
}

#pragma mark - BranchTableViewCellDelegate
- (void)didClickInSection:(NSInteger)section {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate hide:section];
    });
}

@end
