//
//  MessageModel.m
//  IRExtanderTableView
//
//  Created by Phil on 2020/4/1.
//  Copyright © 2020 irons163. All rights reserved.
//

#import "MessageModel.h"
#import "MessageBranchTableViewCell.h"
#import "MessageLeafTableViewCell.h"
#import "FunctionModelBranchItem.h"
#import "FunctionModelLeafItem.h"

@interface MessageModel()<MessageBranchTableViewCellDelegate>

@end

@implementation MessageModel

- (void)regeisterWithTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:MessageBranchTableViewCell.identifier bundle:nil] forCellReuseIdentifier:MessageBranchTableViewCell.identifier];
    [tableView registerNib:[UINib nibWithNibName:MessageLeafTableViewCell.identifier bundle:nil] forCellReuseIdentifier:MessageLeafTableViewCell.identifier];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id<FunctionModelItem> item = [items objectAtIndex:indexPath.section];
    switch (item.type) {
        case BRANCH:
        {
//            MessageBranchTableViewCell* cell =
//            (MessageBranchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MessageBranchTableViewCell.identifier forIndexPath:indexPath];
            MessageBranchTableViewCell* cell = [cells objectForKey:indexPath];
            if(!cell) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:MessageBranchTableViewCell.identifier owner:self options:nil];
                cell = (MessageBranchTableViewCell *)[nib objectAtIndex:0];
                [cells setObject:cell forKey:indexPath];
                [self.delegate attachWithTableView:cell.tableView withIndex:indexPath.section];
                [self.delegate reloadwithIndex:indexPath.section];
            }
            if(cell){
                cell.themeColor = ((FunctionModelBranchItem *)item).session.color;
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tag = indexPath.section;
                cell.delegate = self;
                
                [cell layoutIfNeeded];
                return cell;
            }
        }
        case LEAF:
        {
            MessageLeafTableViewCell* cell =
            (MessageLeafTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MessageLeafTableViewCell.identifier forIndexPath:indexPath];
            if(cell){
                Session *session = ((FunctionModelLeafItem *)item).session;
                Log *log = [session.logs objectAtIndex:indexPath.section];
                cell.nameLabel.text = log.title;
                cell.subTitleLabel.text = log.reason;
//                cell.subTitleLabel.hidden = log.reason.length == 0;
                
//                cell.subTitleLabel.hidden = YES;
                
//                NSString *regex = @"\\(.*\\)";
//                NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex
//                                                                                    options:0
//                                                                                      error:nil];
//                NSTextCheckingResult *match = [re firstMatchInString:log.title
//                                                             options:0
//                                                               range:NSMakeRange(0, log.title.length)];
//                if (match) {
//                    NSString *titlle = [log.title stringByReplacingCharactersInRange:match.range withString:@""];
//                    NSString *subtitle = [log.title substringWithRange:match.range];
//                    subtitle = [subtitle stringByReplacingOccurrencesOfString:@"(" withString:@""];
//                    subtitle = [subtitle stringByReplacingOccurrencesOfString:@")" withString:@""];
//
//                    cell.nameLabel.text = titlle;
//                    cell.subTitleLabel.text = subtitle;
//                    cell.subTitleLabel.hidden = NO;
//                } else {
//                    cell.nameLabel.text = log.title;
//                    cell.subTitleLabel.text = nil;
//                    cell.subTitleLabel.hidden = YES;
//                }
                
//                cell.nameLabel.text = session.reason;
                
                cell.timeLabel.text = log.displayTime;
                cell.rssiLabel.text = [NSString stringWithFormat:@"RSSI%ld", log.rssi];
                
                cell.themeColor = session.color;
                
                cell.isLastItem = items.count - 1 == indexPath.section;
                
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }
        default:
            break;
    }
    return [[UITableViewCell alloc] init];
}

#pragma mark - MessageBranchTableViewCellDelegate
- (void)didClickInSection:(NSInteger)section {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate hide:section];
    });
}

@end
