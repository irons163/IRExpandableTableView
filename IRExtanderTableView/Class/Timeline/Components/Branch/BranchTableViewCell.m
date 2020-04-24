//
//  BranchTableViewCell.m
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import "BranchTableViewCell.h"

@implementation BranchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didClickCell:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickInSection:)]) {
        [_delegate didClickInSection:self.tag];
    }
}

+ (NSString*)identifier{
    return NSStringFromClass([self class]);
}

@end
