//
//  IntegralView.m
//  小助手view
//
//  Created by admin on 8/22/22.
//

#import "IntegralView.h"
#import "Masonry.h"
#import "BtnView.h"
#import "IntergralModel.h"
#import "TopView.h"
#import "VSSDKDefine.h"
#import "integralDetailVC.h"
#import "RewardQueryVC.h"
#import "SDKENTRANCE.h"
#import "VSDKHelper.h"
#import "RewardQueryVC.h"
#import "MallVC.h"
#import "ActiveVC.h"
@interface IntegralView()
@property (nonatomic,strong)BtnView *btnV;
@property (nonatomic,strong)UIStackView *strackV;
@property (nonatomic,strong)IntergralModel *model;
@property (nonatomic,strong)TopView *topV;
//@property (nonatomic,strong)BottomView *bottomV;
@end

@implementation IntegralView

- (TopView *)topV{
    if (_topV == nil) {
        _topV = [[TopView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
        _topV.backgroundColor = VS_RGB(255, 157, 0);
        
    }
    return _topV;
}

-(UIStackView *)strackV{
    if (_strackV == nil) {
        //这里需要根据是否签到调整一下相关内容
        NSArray *iconArr = @[@{@"jfmx":VSLocalString(@"Point Record")},@{@"qd":VSLocalString(@"Sign In")},@{@"ts":VSLocalString(@"Double")},@{@"jlcx":VSLocalString(@"Reward Record")},@{@"jfsc":VSLocalString(@"Point Shop")}];
        if ([IntergralModel sharModel].isSign_time) {
            iconArr = @[@{@"jfmx":VSLocalString(@"Point Record")},@{@"qd":VSLocalString(@"signed in")},@{@"ts":VSLocalString(@"Double")},@{@"jlcx":VSLocalString(@"Reward Record")},@{@"jfsc":VSLocalString(@"Point Shop")}];
            
            if ([IntergralModel sharModel].isPay_time) {
                iconArr = @[@{@"jfmx":VSLocalString(@"Point Record")},@{@"qd":VSLocalString(@"signed in")},@{@"ts_n":VSLocalString(@"Doubled")},@{@"jlcx":VSLocalString(@"Reward Record")},@{@"jfsc":VSLocalString(@"Point Shop")}];
            }
            
        }
        
//        if (![IntergralModel sharModel].isSign_time && ![IntergralModel sharModel].isPay_time) {
//            iconArr = @[@{@"jfmx":@"积分明细"},@{@"qd":@"已签到"},@{@"ts_n":@""},@{@"jlcx":@"奖励查询"},@{@"jfsc":@"积分商城"}];
//        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
//            BtnModel *md = [[BtnModel alloc] init];
//            [arr addObject:md];
            
            NSDictionary *iconDic = iconArr[i];
            NSString *iconStr = iconDic.allValues[0];
            NSString *iconImg = iconDic.allKeys[0];
            
            BtnView *btnV = [[BtnView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            btnV.tag = i;
            btnV.clickBtn.tag = i;
            btnV.imgV.image = [UIImage imageNamed:kSrcName(iconImg)];
            
            if (btnV.clickBtn.tag == 2) {
                btnV.layer.zPosition = MAXFLOAT;
                if ([IntergralModel sharModel].isPay_time) {
                    btnV.imgV.image = [UIImage imageNamed:kSrcName(@"ts_n")];
                    btnV.imgLabel.text = VSLocalString(@"Doubled");
                }else{
                    btnV.imgLabel.text = VSLocalString(@"Double");
                }
            }
            
            btnV.iconLabel.text = iconStr;
            
            
            
            __weak typeof(self) ws = self;
            btnV.clickBlock = ^(NSInteger tag) {
                NSLog(@"%ld",(long)tag);
                [ws integralBtnClick:tag];
            };
            
//            btnV.backgroundColor = [UIColor redColor];
            [btnV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(self.frame.size.width / 6);
                make.height.mas_equalTo(50);
            }];
            [arr addObject:btnV];
            
        }
        
        _strackV = [[UIStackView alloc] initWithArrangedSubviews:arr];
        _strackV.spacing = 20;
        _strackV.axis = UILayoutConstraintAxisHorizontal;
        _strackV.alignment = UIStackViewAlignmentCenter;
        _strackV.distribution = UIStackViewDistributionFillEqually;
    }
    return _strackV;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topV];
        [self addSubview:self.strackV];
//        [self addSubview:self.bottomV];
//        self.topV.backgroundColor = [UIColor grayColor];
//        self.strackV.backgroundColor = [UIColor yellowColor];
//        self.bottomV.backgroundColor = [UIColor greenColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateui_sign:) name:@"UPDATEUI_SIGN" object:nil];
    }
    return self;
}

- (void)layoutSubviews{
    [self.topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(55);
    }];
    
    [self.strackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topV.mas_bottom);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(80);
    }];
    
}

-(void)integralBtnClick:(NSInteger)tag{
    
    switch (tag) {
        case 0:
        {
            [[VSDKHelper sharedHelper] hideAssistant];
            IntegralDetailVC *detailVC = [[IntegralDetailVC alloc] init];
            [SDKENTRANCE showViewController:detailVC];
        }
            break;
        case 3:
        {
            [[VSDKHelper sharedHelper] hideAssistant];
            RewardQueryVC *queryVC = [[RewardQueryVC alloc] init];
            [SDKENTRANCE showViewController:queryVC];
        }
            break;
        case 4:
        {
            //需判断是否进入游戏，如果没进入需要进行提示
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            BOOL isenter = [ud boolForKey:@"ENTERGAME"];
//            if (isenter) {
//                [[VSDKHelper sharedHelper] hideAssistant];
//                MallVC *mallVC = [[MallVC alloc] init];
//                [SDKENTRANCE showViewController:mallVC];
//            }
            
        }
            
        default:
            break;
    }
}

-(void)updateui_sign:(NSNotification *)noti{
//    NSString *point = noti.userInfo[@"point"];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.interalLabel.text = [NSString stringWithFormat:@"当前积分:%@",point];
//    });
}

@end
