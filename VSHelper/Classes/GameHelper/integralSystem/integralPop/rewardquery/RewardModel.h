//
//  RewardModel.h
//  VVSDK
//
//  Created by admin on 9/29/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSString *gift_content;
@property(nonatomic,copy) NSString *gift_name;
@property(nonatomic,copy) NSString *point;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *gift_code;

@end

NS_ASSUME_NONNULL_END
