//
//  BranchHeaderView.h
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeviceDetailHeaderViewDelegate <NSObject>
- (void)didClickAccessButtonInSection:(NSInteger)section;
@end

@interface BranchHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *roundCornerView;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) id<DeviceDetailHeaderViewDelegate>delegate;

@end
