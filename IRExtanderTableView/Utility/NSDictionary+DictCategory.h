//
//  NSDictionary+DictCategory.h
//  IRExtanderTableView
//
//  Created by Phil on 2019/5/6.
//  Copyright © 2019 irons163. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DictCategory)

- (NSDictionary *)dictionaryRemovingNSNullValues;

@end

NS_ASSUME_NONNULL_END
