//
//  TopView.m
//  小助手view
//
//  Created by admin on 8/22/22.
//
#import "VSSDKDefine.h"
#import "TopView.h"
#import "Masonry.h"
#import "ActiveVC.h"
#import "SDKENTRANCE.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 10;
        
        self.tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.interalLabel = [[UILabel alloc] init];
        self.timeLabel = [[MZTimerLabel alloc]initWithTimerType:MZTimerLabelTypeTimer];
        
        [self addSubview:self.tipBtn];
        [self addSubview:self.interalLabel];
        [self addSubview:self.timeLabel];
        
        [self.tipBtn setImage:[UIImage imageNamed:kSrcName(@"xq")] forState:UIControlStateNormal];
        [self.tipBtn addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.interalLabel.text = @"当前积分:221545";
//        self.interalLabel.text = [NSString stringWithFormat:@"当前积分:%@",[IntergralModel sharModel].user_point];
        
        NSString *curPointStr = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Current pts"),[IntergralModel sharModel].user_point];
        self.interalLabel.text = curPointStr;
        
        self.interalLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textColor = [UIColor whiteColor];
//        self.timeLabel.text = @"(43:31后当前积分清零)";
        NSInteger cutdowvalue = [[IntergralModel sharModel].point_clear_time integerValue];
        [self.timeLabel setCountDownTime:cutdowvalue];
        self.timeLabel.delegate = self;
        [self.timeLabel start];
        
        if (DEVICEPORTRAIT) {
            self.interalLabel.font = [UIFont systemFontOfSize:14];
            self.timeLabel.font = [UIFont systemFontOfSize:10];
        }else{
            self.timeLabel.font = [UIFont systemFontOfSize:12];
        }
        
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateui) name:@"UPDATEUI" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateui_sign:) name:@"UPDATEUI_SIGN" object:nil];
        
    }
    return self;
}

-(void)updateui{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.interalLabel.text = [NSString stringWithFormat:@"当前积分:%@",[IntergralModel sharModel].user_point];
    
        NSString *curPointStr = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Current pts"),[IntergralModel sharModel].user_point];
        self.interalLabel.text = curPointStr;
        
        NSInteger cutdowvalue = [[IntergralModel sharModel].point_clear_time integerValue];
        
//        NSInteger cutdowvalue = 259100;
    
        if (259200 > cutdowvalue > 0) {
            self.timeLabel.hidden = NO;
        }
        
        [self.timeLabel setCountDownTime:cutdowvalue];
        self.timeLabel.delegate = self;
        [self.timeLabel start];
        [self.timeLabel startWithEndingBlock:^(NSTimeInterval countTime) {
            self.timeLabel.hidden = YES;
        }];
//    });
    
}

-(void)updateui_sign:(NSNotification *)noti{
    NSString *point = noti.userInfo[@"point"];
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.interalLabel.text = [NSString stringWithFormat:@"当前积分:%@",point];
        NSString *curPointStr = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Current pts"),point];
        self.interalLabel.text = curPointStr;
    });
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, self.frame.size.height));
    }];
    [self.interalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipBtn.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.right.equalTo(self.timeLabel);
        make.height.equalTo(self);
    }];
}

-(void)detailClick:(UIButton *)btn{
    [[VSDKHelper sharedHelper] hideAssistant];
    ActiveVC *activeVC = [[ActiveVC alloc] init];
    [SDKENTRANCE showViewController:activeVC];
}

- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    if([timerLabel isEqual:self.timeLabel]){
        
        NSInteger cutdowvalue = [[IntergralModel sharModel].point_clear_time integerValue];
//        NSInteger cutdowvalue = 259100;

        if (259200 > cutdowvalue && cutdowvalue > 0) {
            self.timeLabel.hidden = NO;
        }else{
            self.timeLabel.hidden = YES;
        }
        
//        int second = (int)time  % 60;
//        int minute = ((int)time / 60) % 60;
//        int hours = time / 3600;
        int days = (int)(time/(3600*24));
        int hours = (int)((time-days*24*3600)/3600);
        int minute = (int)(time-days*24*3600-hours*3600)/60;
        int second = time-days*24*3600-hours*3600-minute*60;
        NSString *tipStr = @"";
        if (hours == 0 && minute == 0){
//            tipStr = [NSString stringWithFormat:@"(%02ds后当前积分清零)",second];
            tipStr = [NSString stringWithFormat:@"Resets in:%02ds",second];
            [self updateLabelWithString:tipStr];
            return tipStr;
        }else if (hours == 0){
//            tipStr = [NSString stringWithFormat:@"(%02dm %02ds后当前积分清零)",minute,second];
            tipStr = [NSString stringWithFormat:@"Resets in:%02dm:%02ds",minute,second];
            [self updateLabelWithString:tipStr];
            return tipStr;
        }else{
//            tipStr = [NSString stringWithFormat:@"(%02dh %02dm %02ds后当前积分清零)",hours,minute,second];
            tipStr = [NSString stringWithFormat:@"Resets in:%02dh:%02dm:%02ds",hours,minute,second];
            [self updateLabelWithString:tipStr];
            return tipStr;
        }
        
      
        
    }
    else
    return nil;
}

-(void)updateLabelWithString:(NSString *)str{
    CGFloat labelw = [VSDeviceHelper sizeWithFontStr:str WithFontSize:12];
     [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.mas_right).offset(-10);
         make.centerY.equalTo(self);
         make.size.mas_equalTo(CGSizeMake(labelw, self.frame.size.height));
     }];
    
    [self.interalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipBtn.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.right.equalTo(self.timeLabel);
        make.height.equalTo(self);
    }];
}
@end
