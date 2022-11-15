//
//  MallModel.h
//  VVSDK
//
//  Created by Macbook on 2022/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallModel : NSObject
@property (nonatomic,assign) NSInteger cur_time;
@property (nonatomic,assign) NSInteger discount_end_time;
@property (nonatomic,assign) NSInteger discount_start_time;
@property (nonatomic,assign) NSInteger goods_send_type;
@property (nonatomic,assign) NSInteger is_exchange;
@property (nonatomic,copy) NSString *gift_use_time;
@property (nonatomic,copy) NSString *gift_id;
@property (nonatomic,copy) NSString *gift_point;
@property (nonatomic,copy) NSString *real_point;
@property (nonatomic,assign) NSInteger times;
@property (nonatomic,copy) NSString *gift_name;
@property (nonatomic,copy) NSString *gift_content;
@property (nonatomic,copy) NSString *remain_number;

@end

NS_ASSUME_NONNULL_END
