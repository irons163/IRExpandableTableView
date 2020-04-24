//
//  MonitorClientsDetailTimelineTableViewCell.h
//  IRExtanderTableView
//
//  Created by Phil on 2020/3/30.
//  Copyright © 2020 irons163. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BranchTableIView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorClientsDetailTimelineTableViewCellDelegate <NSObject>

- (void)willUpdate:(NSNumber *)pos;
- (void)didUpdate:(NSNumber *)pos;

@end

@interface MonitorClientsDetailTimelineTableViewCell : UITableViewCell

@property (weak) id<MonitorClientsDetailTimelineTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet BranchTableIView *timelineTableView;

@property (nonatomic) NSDictionary *clientJourneyData;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
