//
//  ContainerBranch.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/7.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "ContainerBranch.h"

@interface ContainerBranch()<UITableViewDelegate>

@end

@implementation ContainerBranch

- (instancetype)init {
    if(self = [super init]){
        children = [NSMutableArray array];
        model = [[Model alloc] initWithTableView:nil];
        [model updateWithData:self.session];
        model.delegate = self;
        self.isOpened = YES;
    }
    
    return self;
}

- (void)setTableView:(BranchTableIView *)tableView {
    [super setTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

@end
