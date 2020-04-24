//
//  Device.m
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "ClientJourney.h"
#import "Session.h"
#import "NSDictionary+DictCategory.h"

@implementation ClientJourney

- (instancetype)initWithClientJourneyData:(NSDictionary *)dataDictionary {
    self = [super init];
    if (self) {
        dataDictionary = [dataDictionary dictionaryRemovingNSNullValues];
        _total = [dataDictionary[@"total"] integerValue];
        
        NSArray* sessionsDataArray = dataDictionary[@"sessions"];
        NSMutableArray *sessionsArray = [NSMutableArray array];
        for (NSDictionary* sessionDictionary in sessionsDataArray) {
            Session* session = [[Session alloc] initWithClientJourneyData:sessionDictionary];
            [sessionsArray addObject:session];
        }
        
        _sessions = [NSArray arrayWithArray:sessionsArray];
    }
    return self;
}

@end
