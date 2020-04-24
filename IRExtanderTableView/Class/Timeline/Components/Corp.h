//
//  Corp.h
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@protocol Corp <NSObject>

@property (nonatomic) id<Corp> superNode;
@property Session *session;

- (instancetype)initWithData:(Session *)session;
-(void)add:(id<Corp>)corp;
-(void)remove:(id<Corp>)corp;
-(NSArray*)getChildren;
-(void)click;
-(void)loopWillUpdate;
-(void)loopUpdate;
-(void)loopUpdate:(id<Corp>)calledChild;
@end
