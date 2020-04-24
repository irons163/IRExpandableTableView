//
//  MessageBranchFooterView.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageBranchFooterView.h"

@implementation MessageBranchFooterView

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    _lineImageView.backgroundColor = _themeColor;
}

+ (NSString*)identifier{
    return NSStringFromClass([self class]);
}

@end
