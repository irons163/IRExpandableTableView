//
//  NSDictionary+DictCategory.m
//  IRExtanderTableView
//
//  Created by Phil on 2019/5/6.
//  Copyright © 2019 irons163. All rights reserved.
//

#import "NSDictionary+DictCategory.h"

#define REPLACE_STRING @""
@implementation NSDictionary (DictCategory)

- (NSDictionary *)dictionaryRemovingNSNullValues {
    return [self removeNull];
}

#pragma mark - Replace null values to empty string
- (NSDictionary*)removeNull {
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: self];
    
    const id nul = [NSNull null];
    const NSString *blank = REPLACE_STRING;
    
    for (NSString *key in [self allKeys]) {
        
        const id object = [self objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        } else if([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [self replaceNull:object] forKey: key];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced setObject: [self replaceNullArray:object] forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary: replaced];
}

- (NSArray *)replaceNullArray:(NSArray *)array {
    
    const id nul = [NSNull null];
    const NSString *blank = REPLACE_STRING;
    
    NSMutableArray *replaced = [NSMutableArray arrayWithArray:array];
    
    for (int i=0; i < [array count]; i++) {
        const id object = [array objectAtIndex:i];
        if (object == nul) {
            [replaced replaceObjectAtIndex:i withObject:blank];
        } else if([object isKindOfClass: [NSDictionary class]]) {
            [replaced replaceObjectAtIndex:i withObject:[self replaceNull:object]];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced replaceObjectAtIndex:i withObject:[self replaceNullArray:object]];
        }
    }
    return replaced;
}

- (NSDictionary *)replaceNull:(NSDictionary *)dict {
    
    const id nul = [NSNull null];
    const NSString *blank = REPLACE_STRING;
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: dict];
    
    for (NSString *key in [dict allKeys]) {
        const id object = [dict objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        } else if ([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [self replaceNull:object] forKey: key];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced setObject: [self replaceNullArray:object] forKey: key];
        }
    }
    return replaced;
}
@end
