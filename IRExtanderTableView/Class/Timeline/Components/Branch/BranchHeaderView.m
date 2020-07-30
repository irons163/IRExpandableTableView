//
//  BranchHeaderView.m
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "BranchHeaderView.h"

@implementation BranchHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)didClickHeaderView:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickAccessButtonInSection:)]) {
        [_delegate didClickAccessButtonInSection:self.tag];
    }
}

@end
