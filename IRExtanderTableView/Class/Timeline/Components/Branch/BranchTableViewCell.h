//
//  BranchTableViewCell.h
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Branch.h"

@protocol BranchTableViewCellDelegate <NSObject>
- (void)didClickInSection:(NSInteger)section;
@end

@interface BranchTableViewCell : UITableViewCell{
//    Branch *branch;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id<BranchTableViewCellDelegate>delegate;
+ (NSString*)identifier;
@end
