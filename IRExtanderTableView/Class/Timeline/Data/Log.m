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
        _dateSecond = [dataDictionary[@"date"] integerValue] / 1000;
        _reason = dataDictionary[@"reason"];
        _rssi = [dataDictionary[@"rssi"] integerValue];
        _title = dataDictionary[@"title"];
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


@end
