//
//  MessageBranchHeaderView.m
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageBranchHeaderView.h"

@interface MessageBranchHeaderView()

@property (weak, nonatomic) IBOutlet UIView *circleOutterView;
@property (weak, nonatomic) IBOutlet UIView *circleInnerView;
@property (weak, nonatomic) IBOutlet UIView *bandView;
@property (weak, nonatomic) IBOutlet UIView *apToView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineImageViewConstraintWidth;

@end

@implementation MessageBranchHeaderView

- (void)setOpenedInformation:(BOOL)openedInformation {
    _openedInformation = openedInformation;
    
    _informationView.hidden = !_openedInformation;
    [self layoutIfNeeded];
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    _bottomLineImageView.backgroundColor = _circleOutterView.backgroundColor = _circleInnerView.backgroundColor = _apToView.backgroundColor = _ssidLabel.textColor = _themeColor;
    
    [self layoutIfNeeded];
}

- (void)setTagColor:(UIColor *)tagColor {
    _tagColor = tagColor;
    _bandView.backgroundColor = _tagColor;
}

- (void)setOpenedLogs:(BOOL)openedLogs {
    _openedLogs = openedLogs;
    _bottomLineImageViewConstraintWidth.constant = _openedLogs ? 3 : 1;
}

- (void)setRssi:(NSInteger)rssi {
    _rssi = rssi;
    _rssiLabel.text = [NSString stringWithFormat:@"%ld dBm", _rssi];
}

- (IBAction)didClickHeaderView:(id)sender {
    if (_buttonClick) {
        _buttonClick(sender);
    }
}

- (IBAction)informationButtonClick:(id)sender {
    if (_informationButtonClick) {
        _informationButtonClick(sender);
    }
}

+ (NSString*)identifier{
    return NSStringFromClass([self class]);
}

@end
