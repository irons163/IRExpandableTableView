//
//  FunctionModelLeafItem.h
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionModelItem.h"

@interface FunctionModelLeafItem : NSObject<FunctionModelItem>

//@property (nonatomic, readonly) UIColor *color;

- (instancetype)initWithRowCount:(NSUInteger)rowCount;

@end
