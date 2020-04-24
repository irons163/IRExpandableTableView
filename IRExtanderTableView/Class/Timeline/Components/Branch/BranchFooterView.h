//
//  BranchFooterView.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BranchFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaveLabel;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
