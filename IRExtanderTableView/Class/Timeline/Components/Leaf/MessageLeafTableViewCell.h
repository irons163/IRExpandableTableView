//
//  MessageLeafTableViewCell.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageLeafTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *upperLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (nonatomic) UIColor *themeColor;
@property (nonatomic) BOOL isLastItem;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
