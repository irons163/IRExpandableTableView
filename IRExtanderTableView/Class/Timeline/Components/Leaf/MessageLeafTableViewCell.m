//
//  MessageLeafTableViewCell.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageLeafTableViewCell.h"

@interface MessageLeafTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *circleOutterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineImageViewConstraintWidth;

@end

@implementation MessageLeafTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    _upperLineImageView.backgroundColor = _bottomLineImageView.backgroundColor = _circleOutterView.backgroundColor = _themeColor;
}

- (void)setIsLastItem:(BOOL)isLastItem {
    _isLastItem = isLastItem;
    if (_isLastItem) {
        _bottomLineImageViewConstraintWidth.constant = 1;
    } else {
        _bottomLineImageViewConstraintWidth.constant = 3;
    }
}

+ (NSString*)identifier{
    return NSStringFromClass([self class]);
}

@end
