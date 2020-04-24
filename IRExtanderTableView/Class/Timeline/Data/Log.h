//
//  Log.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Log : NSObject

@property (nonatomic, readonly) NSInteger dateSecond;
@property (nonatomic, strong, readonly) NSString* displayDate;
@property (nonatomic, strong, readonly) NSString* displayTime;
@property (nonatomic, strong, readonly) NSString* reason;
@property (nonatomic, readonly) NSInteger rssi;
@property (nonatomic, strong, readonly) NSString* title;

- (instancetype)initWithLogData:(NSDictionary *)dataDictionary;

@end

NS_ASSUME_NONNULL_END
