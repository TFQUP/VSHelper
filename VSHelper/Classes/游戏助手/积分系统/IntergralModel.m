//
//  BtnModel.m
//  小助手view
//
//  Created by admin on 8/22/22.
//

#import "IntergralModel.h"
#import "VSTool.h"
#import "VSSDKDefine.h"
@implementation IntergralModel
+ (IntergralModel *)sharModel{
    static IntergralModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

-(BOOL)isSign_time{
    NSLog(@"%@",self.sign_time);
    NSLog(@"%@",self.curtime);
    
//    self.sign_time = @"1662566400";//2022-09-08
//    self.curtime = @"1662800000";//2022-09-10
    
    //判断是否是同一天
    
    NSInteger signtime = [self timeWithDayCountDown:self.sign_time Withtype:@"dd"];
    NSInteger curtime = [self timeWithDayCountDown:self.curtime Withtype:@"dd"];
    
    if (signtime == curtime) {
        //已经签到过了
        return YES;
    }else{
        return NO;
    }
}

-(NSString *)showSignMsg{
    
    
    
    NSLog(@"%@",self.curtime);
    NSInteger time = [self timeWithDayCountDown:self.curtime Withtype:@"HH"];
//    NSInteger time = [self timeWithTimeCountDown:self.sign_time Withtype:@"H"];
    time = 23 - time;
//    NSString *timeMsg = [NSString stringWithFormat:@"%ld小时后可再次签到",time];
    NSString *timeMsg = [NSString stringWithFormat:VSLocalString(@"Sign in again in %ld hours"),time];
    
    if (time < 1) {
//        time = [self timeWithTimeCountDown:self.sign_time Withtype:@"M"];
        time = [self timeWithDayCountDown:self.curtime Withtype:@"mm"];
//        timeMsg = [NSString stringWithFormat:@"%ld分钟后可再次签到",time];
        timeMsg = [NSString stringWithFormat:VSLocalString(@"Sign in again in %ld minutes"),time];
    }
    return timeMsg;
}

- (BOOL)isPay_time{
    //判断是否是同一天
    NSInteger paytime = [self timeWithDayCountDown:self.pay_time Withtype:@"dd"];
    NSInteger curtime = [self timeWithDayCountDown:self.curtime Withtype:@"dd"];
    
    if (paytime == curtime) {
        //已经加倍过了
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isHot_dot{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *dot = [ud objectForKey:@"HOTDOT"];
    if ([VSTool isBlankString:dot] ) {
        [ud setObject:self.hot_dot forKey:@"HOTDOT"];
        [ud synchronize];
        return YES;
    }else{
        if ([dot isEqualToString:self.hot_dot]) {
            //不显示
            return NO;
        }else{
            [ud setObject:self.hot_dot forKey:@"HOTDOT"];
            [ud synchronize];
            return YES;
        }
    }
}

#pragma mark 时间戳 转日期 （yyyy-MM-dd）
- (NSInteger )timeWithTimeCountDown:(NSString *)timestamp Withtype:(NSString *)type {

    
    NSTimeInterval time = [timestamp doubleValue];
    
    int days = (int)(time/(3600*24));
    int hours = (int)((time-days*24*3600)/3600);
    int minute = (int)(time-days*24*3600-hours*3600)/60;
    int second = time-days*24*3600-hours*3600-minute*60;
    
    if ([type isEqualToString:@"D"]) {
        return (NSInteger)days;
    }else if ([type isEqualToString:@"H"]){
        return (NSInteger)hours;
    }else if([type isEqualToString:@"M"]){
        return (NSInteger)minute;
    }else{
        return (NSInteger)second;
    }
    
}


#pragma mark 时间戳 转日期 （yyyy-MM-dd）
- (NSInteger )timeWithDayCountDown:(NSString *)timestamp Withtype:(NSString *)type {
    // 时间戳转日期
    
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setDateFormat:@"dd"];
    [dateFormatter setDateFormat:type];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
    NSInteger day = [dateStr integerValue];
    return day;
}
@end
