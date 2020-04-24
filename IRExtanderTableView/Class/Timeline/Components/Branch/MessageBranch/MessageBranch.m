//
//  MessageBranch.m
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageBranch.h"
#import "MessageBranchHeaderView.h"
#import "MessageBranchFooterView.h"
#import "MessageModel.h"
#import "BranchFooterView.h"

@interface MessageBranch()<UITableViewDelegate>

@property NSMutableArray<NSNumber *> *openInformations;

- (void)performBranchClickAtSections:(NSArray<NSNumber *> *)sections;

@end

@implementation MessageBranch

- (instancetype)init {
    if(self = [super init]){
        children = [NSMutableArray array];
        model = [[MessageModel alloc] initWithTableView:nil];
        [model updateWithData:self.session];
        model.delegate = self;
        self.isOpened = YES;
        _openInformations = [NSMutableArray array];
    }
    
    return self;
}

- (void)setTableView:(BranchTableIView *)tableView {
    [super setTableView:tableView];
    [self.tableView registerNib:[UINib nibWithNibName:[MessageBranchHeaderView identifier] bundle:nil] forHeaderFooterViewReuseIdentifier:[MessageBranchHeaderView identifier]];
//    [self.tableView registerClass:MessageBranchHeaderView.class forHeaderFooterViewReuseIdentifier:[MessageBranchHeaderView identifier]];
    [self.tableView registerNib:[UINib nibWithNibName:[MessageBranchFooterView identifier] bundle:nil] forHeaderFooterViewReuseIdentifier:[MessageBranchFooterView identifier]];
//    [self.tableView registerClass:MessageBranchFooterView.class forHeaderFooterViewReuseIdentifier:[MessageBranchFooterView identifier]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section != 0){
        return 0;
    }
//    return UITableViewAutomaticDimension;
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section != [model numberOfSectionsInTableView:tableView] - 1){
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if([self tableView:tableView heightForHeaderInSection:section] == 0) {
        return nil;
    }
    
    MessageBranchHeaderView* sectionHeaderView = (MessageBranchHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[MessageBranchHeaderView identifier]];
    
    BOOL isOpened = ![model hiddenRowsinSection:section];
    
    NSString *title = self.session.name;
    
    sectionHeaderView.titleLabel.text = title;
    sectionHeaderView.bandTagLabel.text = self.session.radio;
    sectionHeaderView.iconView.image = self.session.iconImage;
    sectionHeaderView.timeLabel.text = self.session.displayTime;
    sectionHeaderView.apToLabel.text = self.session.apTo;
    sectionHeaderView.ssidLabel.text = self.session.ssid;
    sectionHeaderView.channelLabel.text = [NSString stringWithFormat:@"CH %@",self.session.channel];
    sectionHeaderView.rssi = self.session.rssi;
    sectionHeaderView.logsTitleLabel.text = [NSString stringWithFormat:@"%@ (%ld %@)", self.session.duration, self.session.logs.count, self.session.logs.count > 1 ? @"Events" : @"Event"];
//    sectionHeaderView.leftIcon.image = [model getSectionLeftIconinSection:section];
    sectionHeaderView.tag = section;
    sectionHeaderView.arrowImageView.highlighted = ![model hiddenRowsinSection:section];
    sectionHeaderView.buttonClick = ^(UIButton *button) {
        NSInteger count = [self->model numberOfSectionsInTableView:self.tableView];
        NSMutableArray *sections = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            [sections addObject:@(i)];
        }
        [self performBranchClickAtSections:sections];
    };
    sectionHeaderView.informationButtonClick = ^(UIButton *button) {
        if([self->_openInformations containsObject:@(section)])
            [self->_openInformations removeObject:@(section)];
        else
            [self->_openInformations addObject:@(section)];
//        [tableView reloadData];
        
//        [self.tableView reloadDataWithCompletion:^{
//            [self loopUpdate];
//        }];
//        [self performBranchClickAtSections:@[@(section)]];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//        [UIView setAnimationsEnabled:NO];
//        [self.tableView performBatchUpdates:^{
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//        } completion:^(BOOL finished) {
//            [self loopUpdate];
//        }];
//        });
//        [UIView setAnimationsEnabled:YES];
            BOOL openedInformation = [self->_openInformations containsObject:@(section)];
        //    if (sectionHeaderView.openedInformation != openedInformation) {
                sectionHeaderView.openedInformation = openedInformation;
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [tableView reloadData];
        //        });
        //    }
    };
    
    BOOL openedInformation = [self->_openInformations containsObject:@(section)];
//    if (sectionHeaderView.openedInformation != openedInformation) {
        sectionHeaderView.openedInformation = openedInformation;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [tableView reloadData];
//        });
//    }
    
    sectionHeaderView.openedLogs = isOpened;
    sectionHeaderView.themeColor = self.session.color;
    sectionHeaderView.tagColor = self.session.tagColor;
    
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if([self tableView:tableView heightForFooterInSection:section] == 0) {
        return nil;
    }
    
    if (self.session.leave.length > 0) {
        BranchFooterView* sectionFooterView = (BranchFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[BranchFooterView identifier]];

    //    NSInteger endTime = self.session.dateSecond + (NSInteger)self.session.duration;
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"HH:mm:ss"];
    //    NSString *endTimeString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endTime]];

//        id<FunctionModelItem> item = [model getIteminSection:section];
        Session *session = self.session;
        
        sectionFooterView.timeLabel.text = session.displayDisTime;
        sectionFooterView.titleLabel.text = session.reason;
        sectionFooterView.leaveLabel.text = session.leave;

        sectionFooterView.tag = section;

        return sectionFooterView;
    }
    
    MessageBranchFooterView* sectionFooterView = (MessageBranchFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[MessageBranchFooterView identifier]];
    
    if (self.session.disDateSecond == 0) {
        sectionFooterView.viewConstraintHeight.constant = 10;
        sectionFooterView.titleLabel.text = @"";
    } else {
        sectionFooterView.viewConstraintHeight.constant = 60;
        sectionFooterView.titleLabel.text = self.session.reason;
    }
    [sectionFooterView layoutIfNeeded];
    
    sectionFooterView.tag = section;
    
    sectionFooterView.themeColor = self.session.color;
    
    return sectionFooterView;
}

@end
