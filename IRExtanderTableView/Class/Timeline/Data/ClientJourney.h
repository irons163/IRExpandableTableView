//
//  Device.h
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ClientJourney : NSObject

@property NSString *deviceID;
@property NSString *name;
@property NSString *mac;
@property NSString *model;
@property UIColor *color;

@property (nonatomic,readonly) NSInteger total;
@property (nonatomic,strong,readonly) NSArray *sessions;

- (instancetype)initWithClientJourneyData:(NSDictionary *)dataDictionary;

@end
