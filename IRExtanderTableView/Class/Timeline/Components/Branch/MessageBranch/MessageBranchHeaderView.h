//
//  MessageBranchHeaderView.h
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonClickCallback.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageBranchHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *upperLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineImageView;
@property (weak, nonatomic) IBOutlet UILabel *bandTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *apToLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *logsTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic) ButtonClick buttonClick;
@property (nonatomic) ButtonClick informationButtonClick;

@property (nonatomic) UIColor *themeColor;
@property (nonatomic) UIColor *tagColor;
@property (nonatomic) BOOL openedInformation;
@property (nonatomic) BOOL openedLogs;
@property (nonatomic) NSInteger rssi;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
