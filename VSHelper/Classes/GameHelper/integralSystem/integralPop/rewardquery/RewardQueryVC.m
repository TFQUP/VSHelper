//
//  RewardQueryVC.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "RewardQueryVC.h"
#import "TitleView.h"
#import "Masonry.h"
#import "RewardCell.h"
#import "VSSDKDefine.h"
#import "SDKENTRANCE.h"
#import "RewardModel.h"
@interface RewardQueryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) TitleView *titleV;
@property (nonatomic,strong) UITableView *tabV;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation RewardQueryVC

-(UIView *)mainView{
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 10;
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(TitleView *)titleV{
    if (_titleV == nil) {
        _titleV = [[TitleView alloc] initWithFrame:CGRectZero];
        _titleV.JFSTATE = JLCX;
    }
    return _titleV;
}

-(UITableView *)tabV{
    if (_tabV == nil) {
        _tabV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabV.delegate = self;
        _tabV.dataSource = self;
    }
    return _tabV;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[VSDKAPI shareAPI] vsdk_initPlatformIntegralWithType:3 Success:^(id responseObject) {
        if (REQUESTSUCCESS) {
            NSArray * arr = [responseObject objectForKey:@"data"];
            if (arr.count > 0) {
                self.dataArr = arr;
                [self.tabV reloadData];
                NSLog(@"%@",self.dataArr);
            }
        }
        } Failure:^(NSString *errorMsg) {
            
        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.titleV];
    [self.mainView addSubview:self.tabV];
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn setTitle:VSLocalString(@"Close") forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn.backgroundColor = VS_RGB(255, 157, 0);
    self.closeBtn.layer.masksToBounds = YES;
    self.closeBtn.layer.cornerRadius = 8;
    [self.closeBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.mainView addSubview:self.closeBtn];
    [self setUI];
}

-(void)setUI{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        if(DEVICEPORTRAIT){
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.9, self.view.frame.size.height * 0.5));
        }else{
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.8));
        }
    }];
    [self.titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top);
        make.left.equalTo(self.mainView.mas_left);
        make.right.equalTo(self.mainView.mas_right);
        make.height.mas_equalTo(45);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mainView);
        make.size.mas_equalTo(CGSizeMake(130, 40));
    }];
    
    [self.tabV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleV.mas_bottom);
        make.left.equalTo(self.mainView.mas_left);
        make.right.equalTo(self.mainView.mas_right);
        make.bottom.equalTo(self.closeBtn.mas_top).offset(-10);
    }];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RewardCell *cell = [RewardCell rewardCellWithTableview:tableView];
    NSDictionary *dic = self.dataArr[indexPath.row];
    NSInteger pt = [dic[@"status"] integerValue];
//    cell.rewardNameLabel.text = dic[@"gift_name"];
//    cell.detailLabel.text = dic[@"gift_content"];
////    cell.IntegralLabel.text = [NSString stringWithFormat:@"兑换积分:%@",dic[@"point"]];
//    cell.IntegralLabel.text = [NSString stringWithFormat:@"%@ :%@",VSLocalString(@"Pts"),dic[@"point"]];
//    if (pt == 1) {
//        cell.imagV.image = [UIImage imageNamed:kSrcName(@"vsdk_integral_processing")];
//    }else if (pt == 2){
//        cell.imagV.image = [UIImage imageNamed:kSrcName(@"vsdk_integral_redeemed")];
//    }
////    cell.timeLabel.text = [NSString stringWithFormat:@"兑换时间:%@",[self timeWithYearMonthDayCountDown:dic[@"time"]]];
//    cell.timeLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Time"),[self timeWithYearMonthDayCountDown:dic[@"time"]]];
////    cell.giftCodeLabel.text = [NSString stringWithFormat:@"礼包码:%@",dic[@"gift_code"]];
//    cell.giftCodeLabel.text = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Gift Code"),dic[@"gift_code"]];
//    cell.giftcode = dic[@"gift_code"];
//
//    if ([VSTool isBlankString:cell.giftcode]) {
//        cell.giftCodeLabel.hidden = YES;
//        cell.cpBtn.hidden = YES;
//    }
    
    RewardModel *model = [[RewardModel alloc] init];
    model.status = pt;
    model.gift_name = dic[@"gift_name"];
    model.gift_content = dic[@"gift_content"];
    model.point = dic[@"point"];
    model.time = dic[@"time"];
    model.gift_code = dic[@"gift_code"];
    cell.rmodel = model;
   
//    cell.rewardNameLabel.text = @"白金礼包";
//    cell.detailLabel.text = @"xxxxxxx";
//    cell.IntegralLabel.text = @"兑换积分：XXXX";
//    cell.timeLabel.text = @"兑换时间：XX-XX";
//    cell.giftCodeLabel.text = @"礼包码：xxxx复制";
    return cell;
}

-(void)closeWindow{
//    [[VSDKHelper sharedHelper] showAssistant];
//    [SDKENTRANCE resignWindow];
    
    [SDKENTRANCE resignWindow];
    [[VSDKHelper sharedHelper] showAssistant];
    [[VSDKHelper sharedHelper] assistantBtnClick];
}

- (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp{
    // 时间戳转日期
    
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setDateFormat:@"dd"];
//    [dateFormatter setDateFormat:type];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
//    NSInteger day = [dateStr integerValue];
    return dateStr;
}
@end
