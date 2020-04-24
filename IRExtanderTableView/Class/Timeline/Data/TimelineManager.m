//
//  TimelineManager.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/8.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "TimelineManager.h"
#import "Branch.h"
#import "MessageBranch.h"
#import "ContainerBranch.h"
#import "Leaf.h"
#import "FunctionModelBranchItem.h"
#import "ClientJourney.h"

@implementation TimelineManager

+ (instancetype)sharedInstance {
    static TimelineManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (Branch * _Nonnull)demoBranch {
    Branch *branch;
    
    Session *sessionbranch1 = [[Session alloc] init];
    [sessionbranch1 setValue:[UIColor greenColor] forKey:@"color"];
    [sessionbranch1 setValue:@"leave" forKey:@"leave"];
    [sessionbranch1 setValue:@(11) forKey:@"rssi"];
    [sessionbranch1 setValue:@"100" forKey:@"channel"];
    [sessionbranch1 setValue:@"Room" forKey:@"apTo"];
    [sessionbranch1 setValue:@"TEST1" forKey:@"ssid"];
    Session *sessionbranch2 = [[Session alloc] init];
    [sessionbranch2 setValue:[UIColor blueColor] forKey:@"color"];
    [sessionbranch2 setValue:@"leave" forKey:@"leave"];
    [sessionbranch2 setValue:@(12) forKey:@"rssi"];
    [sessionbranch2 setValue:@"101" forKey:@"channel"];
    [sessionbranch2 setValue:@"DOOR" forKey:@"apTo"];
    [sessionbranch2 setValue:@"TEST2" forKey:@"ssid"];
    
    branch = [[Branch alloc] initWithTableView:nil];
    Branch *branch1 = [[MessageBranch alloc] initWithData:sessionbranch1];
    Branch *branch2 = [[MessageBranch alloc] initWithData:sessionbranch2];
    Leaf *leaf3 = [[Leaf alloc] initWithData:nil];
    Leaf *leaf4 = [[Leaf alloc] initWithData:nil];
    Leaf *leaf5 = [[Leaf alloc] initWithData:nil];
    Leaf *leaf6 = [[Leaf alloc] initWithData:nil];
    
    ContainerBranch *containerBranch = [[ContainerBranch alloc] initWithData:sessionbranch1];
    [containerBranch add:branch1];
    [containerBranch add:branch2];
    [branch add:containerBranch];
    [branch1 add:leaf3];
    [branch1 add:leaf4];
    Log *log = [[Log alloc] initWithLogData:@{@"date":@([NSDate timeIntervalSinceReferenceDate]), @"reason":@"OK", @"rssi":@(200), @"title":@"Connected"}];
    Log *log2 = [[Log alloc] initWithLogData:@{@"date":@([NSDate timeIntervalSinceReferenceDate]), @"reason":@"Fail", @"rssi":@(201), @"title":@"Disconnected"}];
    [sessionbranch1 setValue:@[log, log2] forKey:@"logs"];
    [branch2 add:leaf5];
    [branch2 add:leaf6];
    [sessionbranch2 setValue:@[log, log2] forKey:@"logs"];
    return branch;
}

- (Branch *)branchFromClientJourneyData:(NSDictionary *)dataDictionary {
    
    return [self demoBranch];
    
    Branch *branch = [[Branch alloc] initWithTableView:nil];
    
    ClientJourney *clientJourney = [[ClientJourney alloc] initWithClientJourneyData:dataDictionary];
    
    NSMutableDictionary *containerBranchs = [NSMutableDictionary dictionary];
    NSMutableArray *orderBranchs = [NSMutableArray array];
    for (Session *session in clientJourney.sessions) {
        ContainerBranch *containerBranch = [containerBranchs objectForKey:session.displayDate];
        if(!containerBranch) {
            containerBranch = [[ContainerBranch alloc] initWithData:session];
            [orderBranchs addObject:containerBranch];
            [branch add:containerBranch];
            [containerBranchs setObject:containerBranch forKey:session.displayDate];
        }
        
        Branch *messageBranch = [[MessageBranch alloc] initWithData:session];
        [containerBranch add:messageBranch];
        
        for (Log *log in session.logs) {
            Leaf *leaf = [[Leaf alloc] initWithData:nil];
            [messageBranch add:leaf];
            leaf.isOpened = NO;
        }
    }
    
    for (int i = 0; i < orderBranchs.count; i++) {
        ContainerBranch *branch = [orderBranchs objectAtIndex:i];
        if (i == orderBranchs.count -1) {
            branch.isOpened = YES;
        } else {
            branch.isOpened = NO;
        }
    }
    
    return branch;
}

@end
