//
//  MessageBranchTableViewCell.h
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MessageBranchTableViewCellDelegate <NSObject>
- (void)didClickInSection:(NSInteger)section;
@end

@interface MessageBranchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id<MessageBranchTableViewCellDelegate>delegate;
@property (nonatomic) UIColor *themeColor;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
