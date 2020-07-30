//
//  BranchTableIView.h
//  HierarchyList
//
//  Created by Phil on 2018/5/11.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Branch;

@interface BranchTableIView : UITableView

@property (weak) Branch *bindedBranch;

-(void)reloadDataWithCompletion:(void (^)(void))completionBlock;
-(void)updateTableHeight;

@end
