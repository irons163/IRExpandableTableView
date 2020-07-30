//
//  Leaf.m
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "Leaf.h"
#import "Branch.h"

@implementation Leaf

@synthesize superNode;
@synthesize session;

- (instancetype)initWithData:(Session *)session {
    self = [self init];
    if (self) {
        self.session = session;
        self.isOpened = YES;
    }
    return self;
}

- (void)add:(id)corp {
    NSLog(@"Leaf cannot add something.");
}

- (void)remove:(id<Corp>)corp {
    NSLog(@"Leaf cannot remove something.");
}

- (NSArray *)getChildren {
    return nil;
}

- (void)click {
    self.isOpened = !self.isOpened;
}

- (void)loopUpdate {
    
}

- (void)loopUpdate:(id<Corp>)calledChild {
    
}

- (void)loopWillUpdate {
    
}

- (void)setIsOpened:(BOOL)isOpened {
    if(_isOpened == isOpened)
        return;
    
    _isOpened = isOpened;
    if (superNode) {
        [((Branch*)superNode) hideSectionWithChild:self hide:!_isOpened];
    }
}

@end
