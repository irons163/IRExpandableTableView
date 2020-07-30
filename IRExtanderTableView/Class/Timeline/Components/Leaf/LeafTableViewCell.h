//
//  LeafTableViewCell.h
//  HierarchyList
//
//  Created by Phil on 2018/5/10.
//  Copyright © 2018年 Phil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeafTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
+ (NSString*)identifier;

@end
