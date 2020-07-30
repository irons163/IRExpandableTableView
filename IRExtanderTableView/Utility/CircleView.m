//
//  CircleView.m
//  demo
//
//  Created by Phil on 2019/5/21.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "CircleView.h"

@interface CircleView()

@property (nonatomic, assign) CGFloat cornerRadius;
@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self invalidateIntrinsicContentSize];
        self.cornerRadius = MIN(self.frame.size.width, self.frame.size.height) / 2;
        [self setNeedsLayout];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        [self invalidateIntrinsicContentSize];
        self.cornerRadius = MIN(self.frame.size.width, self.frame.size.height) / 2;
        [self setNeedsLayout];
    }
    
    return self;
}

- (void)prepareForInterfaceBuilder {
    self.cornerRadius = MIN(self.frame.size.width, self.frame.size.height) / 2;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

@end
