//
//  Leaf.h
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Corp.h"

@interface Leaf : NSObject<Corp>

@property (nonatomic) BOOL isOpened;

@end
