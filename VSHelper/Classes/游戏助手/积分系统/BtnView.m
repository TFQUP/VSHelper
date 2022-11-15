//
//  BtnView.m
//  小助手view
//
//  Created by admin on 8/22/22.
//

#import "BtnView.h"
#import "Masonry.h"
#import "VSSDKDefine.h"
#import "TipView.h"
#import "VSDKAPI.h"
#import "MAllVC.h"
#import "SDKENTRANCE.h"
@interface BtnView()
@property (nonatomic,strong)TipView *tipV;
@end

@implementation BtnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc] init];
        self.iconLabel = [[UILabel alloc] init];
        self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imgLabel = [[UILabel alloc] init];
        
        [self addSubview:self.imgV];
        [self.imgV addSubview:self.imgLabel];
        [self addSubview:self.iconLabel];
        [self addSubview:self.clickBtn];
        
        
        [self.clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.iconLabel.textAlignment = NSTextAlignmentCenter;
        self.iconLabel.textColor = VS_RGB(252, 174, 58);
        
        self.imgLabel.textAlignment = NSTextAlignmentCenter;
        self.imgLabel.textColor = [UIColor whiteColor];
        
        
        if (DEVICEPORTRAIT) {
            self.iconLabel.font = [UIFont systemFontOfSize:8];
            self.imgLabel.font = [UIFont systemFontOfSize:8];
        }else{
            self.iconLabel.font = [UIFont systemFontOfSize:12];
            self.imgLabel.font = [UIFont systemFontOfSize:12];
        }
        
        
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        self.tipV = [[TipView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        self.tipV.center = self.center;
        self.tipV.hidden = YES;
        [self addSubview:self.tipV];
        self.tipV.layer.zPosition = MAXFLOAT;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateui_sign:) name:@"UPDATEUI" object:nil];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%ld",self.tag);

    if (self.tag == 2) {
        self.iconLabel.hidden = YES;
//        [self.imgV addSubview:self.imgLabel];
    }else{
//        [self addSubview:self.iconLabel];
        self.imgLabel.hidden = YES;
    }

    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        
        
        if (self.tag == 2) {
            make.height.mas_equalTo(65);
        }else{
            make.height.mas_equalTo(50);
        }
        
//        if ([self.iconLabel.text isEqualToString:@""]) {
//            make.height.mas_equalTo(self.frame.size.height - 30);
//        }else{
//            make.height.mas_equalTo(self.frame.size.height - 40);
//        }
        NSLog(@"%@",NSStringFromCGRect(self.frame));
        NSLog(@"%f",self.frame.size.height);
//        self.imgV.backgroundColor = [UIColor blueColor];
    }];
    
    if (self.tag == 2) {
        [self.imgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.imgV);
            make.height.mas_equalTo(20);
            if (DEVICEPORTRAIT) {
                make.bottom.equalTo(self.imgV.mas_bottom).offset(-12);
            }else{
                make.bottom.equalTo(self.imgV.mas_bottom).offset(-8);
            }
           
            make.centerX.equalTo(self.imgV);
        }];
    }else{
        [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self);
            make.top.equalTo(self.imgV.mas_bottom).mas_offset(-15);
            make.left.equalTo(self);
            make.right.equalTo(self);
            
    //        if ([self.iconLabel.text isEqualToString:@""]) {
    //            make.height.mas_equalTo(0);
    //        }else{
                make.height.mas_equalTo(40);
    //        }

        }];
    }
    
//    self.imgLabel.backgroundColor = [UIColor redColor];
    
    
    
//    self.iconLabel.backgroundColor = [UIColor greenColor];
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [self.tipV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgV);
        if (self.clickBtn.tag == 2) {
            make.size.mas_equalTo(CGSizeMake(200, 45));
//            self.tipV.hidden = NO;
        }else{
            make.size.mas_equalTo(CGSizeMake(80, 45));
        }
        
    }];
}

-(void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 1) {
        if ([IntergralModel sharModel].isSign_time) {
            self.tipV.hidden = NO;
            NSString *msg = [[IntergralModel sharModel] showSignMsg];
            [self showTipWithMsg:msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tipV.hidden = YES;
             });
        }else{
            
            self.tipV.hidden = YES;
            [[VSDKAPI shareAPI] vsdk_initPlatformIntegralWithType:1 Success:^(id responseObject) {
                            //获取参数更新积分，时间签到后要用来倒计时
                if (REQUESTSUCCESS) {
                    NSDictionary * dic = [responseObject objectForKey:@"data"];
//                    NSString *cur_time = dic[@"cur_time"];
//                    NSString *point = dic[@"point"];
//                    NSString *sign_time = dic[@"sign_time"];
//                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//                    [ud setValue:dic forKey:@"PLT_SIGN"];
//                    [ud synchronize];
                    if (dic.count > 0) {
                        IntergralModel *model = [IntergralModel sharModel];
                        model.curtime = dic[@"cur_time"];
                        model.sign_time = dic[@"sign_time"];
//                        self.iconLabel.text = @"已签到";
                        self.iconLabel.text = VSLocalString(@"signed in");
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEUI_SIGN" object:nil userInfo:dic];
                        
                        self.tipV.hidden = NO;
//                        NSString *msg = @"Signed in successfully";
                        NSString *msg = VSLocalString(@"Signed in successfully");
                        [self showTipWithMsg:msg];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.tipV.hidden = YES;
                         });
                        
                    }
                }
                
                
                        } Failure:^(NSString *errorMsg) {
                            
                        }];
        }
    }
    
    if (btn.tag == 2) {
        if ([IntergralModel sharModel].isPay_time) {
        self.imgV.image = [UIImage imageNamed:kSrcName(@"ts_n")];
            self.imgLabel.textColor = VS_RGB(160, 160, 160);
            self.tipV.hidden = NO;
//            NSString *msg = @"已获得两倍积分";
            NSString *msg = VSLocalString(@"Got 2x points");
            [self showTipWithMsg:msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tipV.hidden = YES;
             });
            
        }else{
        self.imgV.image = [UIImage imageNamed:kSrcName(@"ts")];
            self.imgLabel.textColor = [UIColor whiteColor];
            self.tipV.hidden = NO;
//            NSString *msg = @"首充获得双倍积分";
            NSString *msg = VSLocalString(@"Get 2x points after the 1st top-up");
            [self showTipWithMsg:msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tipV.hidden = YES;
             });
        }
    }
    
    if (btn.tag == 4) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        BOOL isenter = [ud boolForKey:@"ENTERGAME"];
        if (isenter) {
            [[VSDKHelper sharedHelper] hideAssistant];
            MallVC *mallVC = [[MallVC alloc] init];
            [SDKENTRANCE showViewController:mallVC];
        }else{
            //提示
            self.tipV.hidden = NO;
//            NSString *msg = @"进入游戏后开启";
            NSString *msg = VSLocalString(@"Open after entering the game");
            [self showTipWithMsg:msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tipV.hidden = YES;
             });
        }
        
    }
    
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
}

-(void)showTipWithMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tipV.tipLabel.text = msg;
    });
    
}

-(void)updateui_sign:(NSNotification *)noti{

//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.interalLabel.text = [NSString stringWithFormat:@"当前积分:%@",point];
//        if (self.imgV.image == [UIImage imageNamed:@"qd"]) {
//            NSLog(@"同一张");
//            self.iconLabel.text = @"已签到";
//        }
        
        if (self.tag == 1) {
            if ([IntergralModel sharModel].isSign_time) {
//                self.iconLabel.text = @"已签到";
                self.iconLabel.text = VSLocalString(@"signed in");
            }else{
//                self.iconLabel.text = @"签到";
                self.iconLabel.text = VSLocalString(@"Sign In");
            }
           
        }
        
        if (self.tag == 2) {
            if ([IntergralModel sharModel].isPay_time) {
            self.imgV.image = [UIImage imageNamed:kSrcName(@"ts_n")];
                self.imgLabel.textColor = VS_RGB(160, 160, 160);
                self.imgLabel.text = VSLocalString(@"Doubled");
            }else{
            self.imgV.image = [UIImage imageNamed:kSrcName(@"ts")];
                self.imgLabel.textColor = [UIColor whiteColor];
                self.imgLabel.text = VSLocalString(@"Double");
            }
        }
    
    
    if (self.imgV.image == [UIImage imageNamed:@"qd"]) {
        if ([IntergralModel sharModel].isSign_time) {
//            self.iconLabel.text = @"已签到";
            self.iconLabel.text = VSLocalString(@"signed in");
        }else{
//            self.iconLabel.text = @"签到";
            self.iconLabel.text = VSLocalString(@"Sign In");
        }
    }
    
    
    if (self.imgV.image == [UIImage imageNamed:@"ts"] || self.imgV.image == [UIImage imageNamed:@"ts_n"]) {
        if ([IntergralModel sharModel].isPay_time) {
        self.imgV.image = [UIImage imageNamed:kSrcName(@"ts_n")];
        self.imgLabel.textColor = VS_RGB(160, 160, 160);
            self.imgLabel.text = VSLocalString(@"Doubled");
        }else{
        self.imgV.image = [UIImage imageNamed:kSrcName(@"ts")];
            self.imgLabel.textColor = [UIColor whiteColor];
            self.imgLabel.text = VSLocalString(@"Double");
        }
    }
    
        
//    });
}
@end
