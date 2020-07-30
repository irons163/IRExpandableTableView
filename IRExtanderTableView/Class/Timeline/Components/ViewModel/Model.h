//
//  Model.h
//  HierarchyList
//
//  Created by Phil on 2018/5/9.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionModelItem.h"
#import "Session.h"

@protocol HierarchyViewModelDelegate <NSObject>

- (void)attachWithTableView:(UITableView *)tableView withIndex:(NSInteger)index;
- (void)reloadwithIndex:(NSInteger)index;
- (void)reload;
- (void)hide:(NSInteger)section;

@end

@interface Model : NSObject <UITableViewDataSource>{
@protected
    NSMutableArray<FunctionModelItem>* items;
    NSArray* infoTitleItems;
    Session* _session;
    NSMutableDictionary<NSIndexPath *, UITableViewCell *> *cells;
}

@property (weak) id<HierarchyViewModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithTableView:(UITableView*)tableView;
- (void)regeisterWithTableView:(UITableView*)tableView;
- (void)updateWithData:(Session*)session;
- (NSString *)getSectionTitleinSection:(NSInteger)section;
- (UIImage *)getSectionLeftIconinSection:(NSInteger)section;
- (FunctionType)getFunctionTypeinSection:(NSInteger)section;
- (void)hideRows:(BOOL)hide inSection:(NSInteger)section;
- (BOOL)hiddenRowsinSection:(NSInteger)section;
- (void)addItem:(id<FunctionModelItem>)item;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)hideAll:(UITableView *)tableView;
- (void)loadAll:(UITableView *)tableView;
- (id<FunctionModelItem>)getIteminSection:(NSInteger)section;
- (NSInteger)getCountOfItems;

@end
