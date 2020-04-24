//
//  MessageBranchFooterView.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageBranchFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewConstraintHeight;
@property (nonatomic) UIColor *themeColor;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
