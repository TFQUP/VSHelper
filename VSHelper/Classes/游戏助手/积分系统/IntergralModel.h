//
//  BtnModel.h
//  小助手view
//
//  Created by admin on 8/22/22.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntergralModel : NSObject
+(IntergralModel *)sharModel;
@property (nonatomic,copy) NSString *curtime;
@property (nonatomic,copy) NSString *idescription;
@property (nonatomic,copy) NSString *hot_dot;
@property (nonatomic,copy) NSString *point_clear_time;
@property (nonatomic,copy) NSString *pay_time;
@property (nonatomic,copy) NSString *sign_time;
@property (nonatomic,copy) NSString *user_point;

@property (nonatomic,assign) BOOL isSign_time;
@property (nonatomic,assign) BOOL isPay_time;
@property (nonatomic,assign) BOOL isHot_dot;

@property (nonatomic,assign) BOOL point_state;//是否开启平台积分功能1开，0

-(NSString *)showSignMsg;
@end

NS_ASSUME_NONNULL_END
