//
//  TimelineManager.h
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Branch.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimelineManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype)sharedInstance;

- (Branch *)branchFromClientJourneyData:(NSDictionary *)dataDictionary;

@end

NS_ASSUME_NONNULL_END
