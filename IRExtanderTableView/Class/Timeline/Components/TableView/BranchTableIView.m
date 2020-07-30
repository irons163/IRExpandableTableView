//
//  BranchTableIView.m
//  HierarchyList
//
//  Created by Phil on 2018/5/11.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "BranchTableIView.h"
#import "BranchTableViewCell.h"
#import "LeafTableViewCell.h"

@interface BranchTableIView()

@property (nonatomic, copy) void (^reloadDataCompletionBlock)(void);
@end

@implementation BranchTableIView{
    NSLayoutConstraint *tableHeightConstraint;
}

- (instancetype)init {
    if(self = [super init]){
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    
    return self;
}

- (void)setup {
    [self registerNib:[UINib nibWithNibName:BranchTableViewCell.identifier bundle:nil] forCellReuseIdentifier:BranchTableViewCell.identifier];
    [self registerNib:[UINib nibWithNibName:LeafTableViewCell.identifier bundle:nil] forCellReuseIdentifier:LeafTableViewCell.identifier];
    [self registerNib:[UINib nibWithNibName:@"BranchHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BranchHeaderView"];
    self.estimatedRowHeight = UITableViewAutomaticDimension;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.sectionFooterHeight = 0.0001f;
    tableHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    tableHeightConstraint.priority = UILayoutPriorityDefaultHigh;
    tableHeightConstraint.active = YES;
}

- (void)updateConstraints {
    [super updateConstraints];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.reloadDataCompletionBlock) {
        self.reloadDataCompletionBlock();
        self.reloadDataCompletionBlock = nil;
    }
}

- (void)reloadDataWithCompletion:(void (^)(void))completionBlock {
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"reload completed");
        self->tableHeightConstraint.constant = self.contentSize.height;
        if(completionBlock)
            completionBlock();
    }];
    NSLog(@"reloading");
    [super reloadData];
    [CATransaction commit];
}

- (void)updateTableHeight {
    tableHeightConstraint.constant = self.contentSize.height;
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    tableHeightConstraint.constant = self.contentSize.height;
}

@end
