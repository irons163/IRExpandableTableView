//
//  Session.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Log.h"

NS_ASSUME_NONNULL_BEGIN

@interface Session : NSObject

@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, readonly) NSInteger dateSecond;
@property (nonatomic, strong, readonly) NSDate* date;
@property (nonatomic, strong, readonly) NSString* displayDate;
@property (nonatomic, strong, readonly) NSString* displayTime;
@property (nonatomic, readonly) NSInteger disDateSecond;
@property (nonatomic, strong, readonly) NSString* displayDisTime;
@property (nonatomic, strong, readonly) NSString* apTo;
@property (nonatomic, strong, readonly) NSString* ssid;
@property (nonatomic, strong, readonly) NSString* radio;
@property (nonatomic, strong, readonly) NSString* channel;
@property (nonatomic, readonly) NSInteger rssi;
@property (nonatomic, strong, readonly) NSString* duration;
@property (nonatomic, strong, readonly) NSString* reason;
@property (nonatomic, strong, readonly) NSString* leave;
@property (nonatomic, strong, readonly) NSArray<Log*>* logs;

@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, strong, readonly) UIColor *tagColor;
@property (nonatomic, strong) UIImage *iconImage;

- (instancetype)initWithClientJourneyData:(NSDictionary *)dataDictionary;

@end

NS_ASSUME_NONNULL_END
