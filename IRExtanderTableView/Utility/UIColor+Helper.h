//
//  UIColor+Helper.h
//  EnShare
//
//  Created by Phil on 2015/7/29.
//  Copyright (c) 2015年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorDefine.h"

@interface UIColor (Helper)
+ (UIColor *)colorWithColorCodeString:(NSString*)colorString;
+ (UIColor *)colorWithARGB:(NSUInteger)color;
+ (UIColor *)colorWithRGB:(NSUInteger)color;
+ (UIColor *)colorWithRGBA:(NSUInteger)color;
+ (UIColor *)colorWithRGBWithString:(NSString*)colorString;
@end
