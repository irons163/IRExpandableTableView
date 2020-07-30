//
//  Branch.h
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Corp.h"
#import "Model.h"
#import "BranchTableIView.h"

@protocol BranchDelegate <NSObject>

- (void)willUpdate:(NSNumber *)pos;
- (void)didUpdate:(NSNumber *)pos;

@end

@interface Branch : NSObject<Corp>{
    NSMutableArray *children;
    Model *model;
}

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property (weak) id<BranchDelegate> delegate;
@property (nonatomic) BOOL isOpened;
@property BOOL isNeedReload;
@property (weak, nonatomic) BranchTableIView *tableView;

- (instancetype)initWithTableView:(UITableView*)tableView;
- (void)hideSectionWithChild:(id<Corp>)child hide:(BOOL)hide;

@end

@interface Branch(Protect)<HierarchyViewModelDelegate>

- (void)performBranchClickAtSections:(NSArray<NSNumber *> *)sections;

@end
