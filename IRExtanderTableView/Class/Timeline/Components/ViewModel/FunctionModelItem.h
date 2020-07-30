//
//  FunctionModelItem.h
//
//  Created by Phil on 2018/3/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Session.h"

typedef NS_ENUM(NSInteger, FunctionType){
    BRANCH,
    LEAF
};

@protocol FunctionModelItem <NSObject>
@property (nonatomic) BOOL hideCells;
- (FunctionType)type;
- (NSInteger)rowCount;
- (NSString *)rowTitleForIndex:(NSInteger)rowIndex;
- (NSString *)sectionTitle;
- (UIImage *)sectionLeftIcon;
- (void)updateWithData:(Session *)session;
- (Session *)session;

@end
