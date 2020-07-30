//
//  FunctionModelLeafItem.m
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "FunctionModelLeafItem.h"

@implementation FunctionModelLeafItem{
    NSUInteger _rowCount;
    Session *_session;
}
@synthesize hideCells;

- (instancetype)initWithRowCount:(NSUInteger)rowCount {
    if(self = [self init]){
        _rowCount = 1;
    }
    return self;
}

- (NSInteger)rowCount {
    if(self.hideCells)
        return 0;
    return _rowCount;
}

- (NSString*)rowTitleForIndex:(NSInteger)rowIndex{
    switch (rowIndex) {
        case 0:
            return _session.reason;
            
        default:
            return nil;
    }
}

- (NSString *)sectionTitle {
    return nil;
}

- (UIImage *)sectionLeftIcon {
    return nil;
}

- (FunctionType)type {
    return LEAF;
}

- (void)updateWithData:(Session *)session{
    _session = session;
}

- (Session *)session {
    return _session;
}

@end
