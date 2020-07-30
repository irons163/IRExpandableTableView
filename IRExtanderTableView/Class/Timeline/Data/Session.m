//
//  Session.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "Session.h"
#import "Log.h"
#import "NSDictionary+DictCategory.h"
#import "UIColor+Helper.h"

@implementation Session

- (instancetype)initWithClientJourneyData:(NSDictionary *)dataDictionary {
    if (self = [super init]) {
        dataDictionary = [dataDictionary dictionaryRemovingNSNullValues];
        _name = dataDictionary[@"name"];
        _dateSecond = [dataDictionary[@"date"] integerValue] / 1000;
        _disDateSecond = [dataDictionary[@"dis_date"] integerValue] / 1000;
        _apTo = dataDictionary[@"ap_to"];
        _ssid = dataDictionary[@"ssid"];
        _radio = dataDictionary[@"radio"];
        _channel = dataDictionary[@"channel"];
        _rssi = [dataDictionary[@"rssi"] integerValue];
        _duration = dataDictionary[@"duration"];
        _reason = dataDictionary[@"reason"];
        _leave = dataDictionary[@"leave"];
        
        NSArray* logsDataArray = dataDictionary[@"logs"];
        NSMutableArray *logsArray = [NSMutableArray array];
        for (NSDictionary* logDictionary in logsDataArray) {
            Log* network = [[Log alloc] initWithLogData:logDictionary];
            [logsArray addObject:network];
        }
        
        _logs = [NSArray arrayWithArray:logsArray];
        
        if ([_radio isEqualToString:@"5G"]) {
            _tagColor = [UIColor colorWithColorCodeString:band5GColor];
        } else {
            _tagColor = [UIColor colorWithColorCodeString:band24GColor];
        }
        
        if ([_name isEqualToString:@"deny"]) {
            _color = [UIColor colorWithColorCodeString:denyColor];
        } else {
            _color = _tagColor;
        }
    }
    return self;
}

- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.dateSecond];
}

- (NSString *)displayDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:self.date];
}

- (NSString *)displayTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];
    return [formatter stringFromDate:self.date];
}

- (NSString *)displayDisTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.disDateSecond]];
}

@end
