//
//  Log.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "Log.h"
#import "NSDictionary+DictCategory.h"

@implementation Log

- (instancetype)initWithLogData:(NSDictionary *)dataDictionary {
    if (self = [super init]) {
        dataDictionary = [dataDictionary dictionaryRemovingNSNullValues];
        _aid = dataDictionary[@"aid"];
        _dateSecond = [dataDictionary[@"date"] integerValue] / 1000;
        _event = dataDictionary[@"event"];
        _reason = dataDictionary[@"reason"];
        _rssi = [dataDictionary[@"rssi"] integerValue];
        _ratio5G = dataDictionary[@"ratio5G"];
        _title = dataDictionary[@"title"];
    }
    return self;
}

- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.dateSecond];
}

- (NSString *)displayDate {
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:self.dateSecond];
//    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:self.timeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:timezone];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:self.date];
}

- (NSString *)displayTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];
    return [formatter stringFromDate:self.date];
}


@end
