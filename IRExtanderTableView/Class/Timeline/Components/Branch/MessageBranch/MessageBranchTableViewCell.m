//
//  MessageBranchTableViewCell.m
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageBranchTableViewCell.h"

@interface MessageBranchTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *circleOutterView;
@property (weak, nonatomic) IBOutlet UIView *circleInnerView;

@end

@implementation MessageBranchTableViewCell

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
    _circleOutterView.backgroundColor = _circleInnerView.backgroundColor =  _themeColor;
}

- (IBAction)didClickCell:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickInSection:)]) {
        [_delegate didClickInSection:self.tag];
    }
}

+ (NSString*)identifier{
    return NSStringFromClass([self class]);
}

@end
