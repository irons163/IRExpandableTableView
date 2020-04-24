//
//  ViewController.m
//  IRExtanderTableView
//
//  Created by irons on 2020/4/22.
//  Copyright © 2020 irons. All rights reserved.
//

#import "ViewController.h"
#import "MonitorClientsDetailTimelineTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, MonitorClientsDetailTimelineTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property NSDictionary *clientJourneyData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [_tableView registerNib:[UINib nibWithNibName:MonitorClientsDetailTimelineTableViewCell.identifier bundle:nil] forCellReuseIdentifier:MonitorClientsDetailTimelineTableViewCell.identifier];
}

#pragma mark - Private
- (void)showLoading:(BOOL)isShow
{
    dispatch_block_t block = ^{
        if (isShow) {
            self.view.userInteractionEnabled = NO;
            [self.loadingView startAnimating];
        }else{
            self.view.userInteractionEnabled = YES;
            [self.loadingView stopAnimating];
        }
    };
    
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MonitorClientsDetailTimelineTableViewCell *cell = (MonitorClientsDetailTimelineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MonitorClientsDetailTimelineTableViewCell.identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.delegate = self;
    cell.clientJourneyData = _clientJourneyData;
    [cell layoutIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 1) {
//        return 200;
//    } else {
//        return UITableViewAutomaticDimension;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)willUpdate:(NSNumber *)pos {
    [self showLoading:YES];
}

- (void)didUpdate:(NSNumber *)pos {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView performBatchUpdates:^{
            
        } completion:^(BOOL finished) {
            [self showLoading:NO];
        }];
    });
}

@end
