//
//  MallVC.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "MallVC.h"
#import "TitleView.h"
#import "Masonry.h"
#import "MaillCell.h"
#import "VSSDKDefine.h"
#import "UIControl+Btnproperty.h"
#import "MallModel.h"
#import "SDKENTRANCE.h"

@interface MallVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) TitleView *titleV;
@property (nonatomic,strong) UITableView *tabV;

//提示view
@property(nonatomic,strong) UIView *giftView;
@property(nonatomic,strong) UILabel *giftLabel;
@property(nonatomic,strong) UIButton *giftBtn;

//确认view
@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,strong) UIView *confimView;
@property(nonatomic,strong) UILabel *exchangeLabel;
@property(nonatomic,strong) UILabel *serviceLabel;
@property(nonatomic,strong) UILabel *userIdLabel;
@property(nonatomic,strong) UILabel *userNameLabel;
@property(nonatomic,strong) UILabel *msgLabel1;
@property(nonatomic,strong) UILabel *msgLabel2;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,strong) UIView *topV;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *closeBtn;

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,copy) NSString *goodid;//自动兑换的礼包码
@property (nonatomic,copy) NSString *codetag;//商品id

@property (nonatomic,strong) UIButton *closeVBtn;
@end

@implementation MallVC
-(UIView *)topV{
    if (_topV == nil) {
        _topV = [[UIView alloc] init];
        _topV.backgroundColor = VS_RGB(255, 157, 0);
        _titleLabel = [[UILabel alloc] init];
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:kSrcName(@"Iback")] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(gobackClick) forControlEvents:UIControlEventTouchUpInside];
        [_topV addSubview:_titleLabel];
        [_topV addSubview:_closeBtn];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"活动规则";
        _titleLabel.text = VSLocalString(@"Role Info");
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _topV;
}

-(void)gobackClick{
    self.confimView.hidden = YES;
}

-(UIView *)confimView{
    if (_confimView == nil) {
        _confimView = [[UIView alloc] init];
        _centerView = [[UIView alloc] init];
        _exchangeLabel = [[UILabel alloc] init];
        _serviceLabel = [[UILabel alloc] init];
        _userIdLabel = [[UILabel alloc] init];
        _userNameLabel = [[UILabel alloc] init];
        _msgLabel1 = [[UILabel alloc] init];
        _msgLabel2 = [[UILabel alloc] init];
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitle:VSLocalString(@"Submit") forState:UIControlStateNormal];
        [_confimView addSubview:_centerView];
        [_centerView addSubview:self.topV];
        [_centerView addSubview:_exchangeLabel];
        [_centerView addSubview:_serviceLabel];
        [_centerView addSubview:_userIdLabel];
        [_centerView addSubview:_userNameLabel];
        [_centerView addSubview:_msgLabel1];
        [_centerView addSubview:_msgLabel2];
        [_centerView addSubview:_submitBtn];
        
        UIColor *color = [UIColor blackColor];
        _confimView.backgroundColor = [color colorWithAlphaComponent:0.5];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.masksToBounds = YES;
        _centerView.layer.cornerRadius = 10;
        _msgLabel1.textAlignment = NSTextAlignmentCenter;
        _msgLabel2.textAlignment = NSTextAlignmentCenter;
        
        _submitBtn.backgroundColor = VS_RGB(255, 157, 0);
        _submitBtn.layer.cornerRadius = 8;
        [_submitBtn addTarget:self action:@selector(closeViewWithGoodId:) forControlEvents:UIControlEventTouchUpInside];
        
//        NSString * roleLevel = VS_USERDEFAULTS_GETVALUE(@"vsdk_role_level") == nil ? @"":VS_USERDEFAULTS_GETVALUE(@"vsdk_role_level");
//        NSString * serviceid = VS_USERDEFAULTS_GETVALUE(@"vsdk_role_serviceid") == nil ? @"":VS_USERDEFAULTS_GETVALUE(@"vsdk_role_serviceid");
        NSString * servername = VS_USERDEFAULTS_GETVALUE(@"vsdk_role_servername") == nil ? @"":VS_USERDEFAULTS_GETVALUE(@"vsdk_role_servername");
        NSString * roleid = VS_USERDEFAULTS_GETVALUE(@"vsdk_role_roleid") == nil ? @"":VS_USERDEFAULTS_GETVALUE(@"vsdk_role_roleid");
        NSString * rolename = VS_USERDEFAULTS_GETVALUE(@"vsdk_role_rolename") == nil ? @"":VS_USERDEFAULTS_GETVALUE(@"vsdk_role_rolename");
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        
//        _exchangeLabel.text = @"兑换游戏：XXXX";
//        _userIdLabel.text = @"角色ID：XXXX";
//        _serviceLabel.text = @"服务器：XXXX";
//        _userNameLabel.text = @"角色名称：XXXX";
//        _msgLabel1.text = @"请确定上述信息，确定后提交";
//        _msgLabel2.text = @"若角色有误，请退出游戏，进行角色切换";
        
        _exchangeLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Game"),app_Name];
        _userIdLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Role ID"),roleid];
        _serviceLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Server"),servername];
        _userNameLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Role Name"),rolename];
        _msgLabel1.text = VSLocalString(@"Please confirm the info before submitting");
        _msgLabel2.text = VSLocalString(@"You can switch to other roles by re-login");
        
        if (DEVICEPORTRAIT) {
            _exchangeLabel.font = _userIdLabel.font = _serviceLabel.font = _userNameLabel.font = [UIFont systemFontOfSize:12];
            _msgLabel1.font = _msgLabel2.font = [UIFont systemFontOfSize:11];
        }else{
            _exchangeLabel.font = _userIdLabel.font = _serviceLabel.font = _userNameLabel.font = [UIFont systemFontOfSize:15];
            _msgLabel1.font = _msgLabel2.font = [UIFont systemFontOfSize:12];
        }
    }
    return _confimView;
}

-(UIView *)giftView{
    if (_giftView == nil) {
        _giftView = [[UIView alloc] initWithFrame:CGRectZero];
        UIColor *color = [UIColor blackColor];
        _giftView.backgroundColor = [color colorWithAlphaComponent:0.5];
        _giftView.layer.cornerRadius = 10;
        _giftLabel = [[UILabel alloc] init];
        _giftLabel.textColor = [UIColor whiteColor];
//        _giftLabel.textAlignment = NSTextAlignmentCenter;
        _giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_giftBtn setTitleColor:VS_RGB(255, 157, 0) forState:UIControlStateNormal];
        _giftBtn.backgroundColor = [UIColor clearColor];
//        [_giftBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_giftBtn setTitle:VSLocalString(@"Copy") forState:UIControlStateNormal];
        [_giftBtn addTarget:self action:@selector(CPClick:) forControlEvents:UIControlEventTouchUpInside];
        [_giftView addSubview:_giftLabel];
        [_giftView addSubview:_giftBtn];
    }
    return _giftView;
}

-(UIView *)mainView{
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 10;
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(UIButton *)closeVBtn{
    if (_closeVBtn == nil) {
        _closeVBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeVBtn setImage:[UIImage imageNamed:kSrcName(@"vsdk_outside_close.png")] forState:UIControlStateNormal];
        [_closeVBtn addTarget:self action:@selector(closeAllView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeVBtn;
}

-(TitleView *)titleV{
    if (_titleV == nil) {
        _titleV = [[TitleView alloc] initWithFrame:CGRectZero];
        _titleV.JFSTATE = JFSC;
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
    [self reloadeMallData];
}

-(void)reloadeMallData{
    [[VSDKAPI shareAPI] vsdk_initPlatformIntegralWithType:4 Success:^(id responseObject) {
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
    [self.view addSubview:self.closeVBtn];
    [self.mainView addSubview:self.titleV];
    [self.mainView addSubview:self.tabV];
    
    [self.view addSubview:self.giftView];
//    self.giftLabel.text = [NSString stringWithFormat:@"礼包码:%@",@"XXXXXX"];
    self.giftView.hidden = YES;
    
    [self.view addSubview:self.confimView];
    self.confimView.hidden = YES;
    [self setUI];
}

-(void)setUI{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        if(DEVICEPORTRAIT){
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.9, self.view.frame.size.height * 0.55));
        }else{
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.8));
        }
    }];
    
    [self.closeVBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
        if (DEVICEPORTRAIT) {
            make.bottom.equalTo(self.mainView.mas_top).mas_equalTo(-5);
            make.right.equalTo(self.mainView.mas_right);
        }else{
            make.left.equalTo(self.mainView.mas_right).mas_equalTo(5);
            make.top.equalTo(self.mainView.mas_top);
        }
    }];
    
    [self.titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top);
        make.left.equalTo(self.mainView.mas_left);
        make.right.equalTo(self.mainView.mas_right);
        make.height.mas_equalTo(45);
    }];
    
    [self.tabV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleV.mas_bottom);
        make.left.equalTo(self.mainView.mas_left);
        make.right.equalTo(self.mainView.mas_right);
        make.bottom.equalTo(self.mainView).offset(-20);
    }];
    
    [self.mainView layoutIfNeeded];
    [self.giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mainView);
        make.size.mas_equalTo(CGSizeMake(240, 60));
    }];
//    [self.giftView layoutIfNeeded];
    [self.giftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.giftView.mas_left).offset(20);
        make.centerY.equalTo(self.giftView);
        make.size.mas_equalTo(CGSizeMake(240, 50));
    }];
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.giftView);
        make.size.mas_equalTo(CGSizeMake(80, 45));
        make.right.equalTo(self.giftView.mas_right).offset(0);
    }];
    
    
    [self.confimView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height));
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    [self.mainView layoutIfNeeded];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mainView);
        
        if(DEVICEPORTRAIT){
            make.size.mas_equalTo(CGSizeMake(self.mainView.frame.size.width * 0.9, self.mainView.frame.size.height * 0.9));
        }else{
            make.size.mas_equalTo(CGSizeMake(self.mainView.frame.size.width * 0.8, self.mainView.frame.size.height * 0.8));
        }
        
        
    }];
    
    [self.confimView layoutIfNeeded];
    if (DEVICEPORTRAIT) {
        
        [self.topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerView.mas_top);
            make.left.equalTo(self.centerView.mas_left);
            make.right.equalTo(self.centerView.mas_right);
            make.height.mas_equalTo(45);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.topV);
            make.center.equalTo(self.topV);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topV.mas_left).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(35, 35));
            make.centerY.equalTo(self.topV);
        }];
        
        [self.exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left).offset(20);
            make.top.equalTo(self.topV.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.centerView.mas_right).offset(0);
            make.top.equalTo(self.topV.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left).offset(20);
            make.top.equalTo(self.exchangeLabel.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.centerView.mas_right).offset(0);
            make.top.equalTo(self.serviceLabel.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.msgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userIdLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.centerView);
            make.size.mas_equalTo(CGSizeMake(self.centerView.frame.size.width, 40));
        }];
        [self.msgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.msgLabel1.mas_bottom).offset(-5);
            make.centerX.equalTo(self.confimView);
            make.size.mas_equalTo(CGSizeMake(self.centerView.frame.size.width, 40));
        }];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.centerView.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
            make.centerX.equalTo(self.centerView);
        }];
        
        [self.userNameLabel layoutIfNeeded];
        [self.userIdLabel layoutIfNeeded];
        [self.msgLabel1 layoutIfNeeded];
        [self.msgLabel2 layoutIfNeeded];
        CGFloat vh = self.userNameLabel.frame.size.height + 20 + self.userIdLabel.frame.size.height + 20 + self.msgLabel1.frame.size.height + 20 + self.msgLabel2.frame.size.height + 20 + 45;
        NSLog(@"%lf",vh);
        [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.mainView);
            
            if(DEVICEPORTRAIT){
                make.size.mas_equalTo(CGSizeMake(self.mainView.frame.size.width * 0.9, vh));
            }else{
                make.size.mas_equalTo(CGSizeMake(self.mainView.frame.size.width * 0.8, self.mainView.frame.size.height * 0.8));
            }
        }];
        
    }else{
        
        [self.topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerView.mas_top);
            make.left.equalTo(self.centerView.mas_left);
            make.right.equalTo(self.centerView.mas_right);
            make.height.mas_equalTo(45);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.topV);
            make.center.equalTo(self.topV);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topV.mas_left).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(35, 35));
            make.centerY.equalTo(self.topV);
        }];
        
        [self.exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left).offset(self.confimView.frame.size.width * 0.1);
            make.top.equalTo(self.topV.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.centerView.mas_right).offset(self.confimView.frame.size.width * 0.05);
            make.top.equalTo(self.topV.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_left).offset(self.confimView.frame.size.width * 0.1);
            make.top.equalTo(self.exchangeLabel.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.centerView.mas_right).offset(self.confimView.frame.size.width * 0.05);
            make.top.equalTo(self.serviceLabel.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(self.confimView.frame.size.width * 0.3, 40));
        }];
        [self.msgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userIdLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.centerView);
            make.size.mas_equalTo(CGSizeMake(self.centerView.frame.size.width, 40));
        }];
        [self.msgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.msgLabel1.mas_bottom).offset(-5);
            make.centerX.equalTo(self.confimView);
            make.size.mas_equalTo(CGSizeMake(self.centerView.frame.size.width, 40));
        }];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.centerView.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(self.centerView.frame.size.width * 0.6, 45));
            make.centerX.equalTo(self.centerView);
        }];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaillCell *cell = [MaillCell mallCellWithTableview:tableView];
    MallModel *model = [[MallModel alloc] init];
    // 修改富文本中的不同文字的样式
    NSDictionary *dic = self.dataArr[indexPath.row];
    NSInteger cur_time = [dic[@"cur_time"] integerValue];
    NSInteger discount_end_time = [dic[@"discount_end_time"] integerValue];
    NSInteger discount_start_time = [dic[@"discount_start_time"] integerValue];
//    NSInteger gift_use_time = [dic[@"gift_use_time"] integerValue];
    NSString *gift_use_time = dic[@"gift_use_time"];
    NSString *gift_id = dic[@"gift_id"];
    NSString *gift_point = dic[@"gift_point"];
    NSInteger goods_send_type = [dic[@"goods_send_type"] integerValue];
    NSInteger is_exchange = [dic[@"is_exchange"] integerValue];
//    NSString *is_exchange = dic[@"is_exchange"];
    NSString *real_point = dic[@"real_point"];
    NSString *timestr = dic[@"times"];
    NSInteger times = [timestr integerValue];
    
    model.cur_time = cur_time;
    model.discount_start_time = discount_start_time;
    model.discount_end_time = discount_end_time;
    model.gift_use_time = gift_use_time;
    model.gift_id = gift_id;
    model.gift_point = gift_point;
    model.goods_send_type = goods_send_type;
    model.is_exchange = is_exchange;
    model.real_point = real_point;
    model.times = times;
    model.gift_name = dic[@"gift_name"];
    model.gift_content = dic[@"gift_content"];
    model.remain_number = dic[@"remain_number"];
    cell.MModel = model;
    
    cell.exchangeBtn.CodeTags = gift_id;
    NSString *sendtype = [NSString stringWithFormat:@"%ld",goods_send_type];
    cell.exchangeBtn.ChangeType = sendtype;
    [cell.exchangeBtn addTarget:self action:@selector(redmeeClick:) forControlEvents:UIControlEventTouchUpInside];

    
//    cell.attributeStr = attriStr1;
//    [cell setUI];
    return cell;
}

-(void)closeViewWithGoodId:(UIButton *)btn{
    
    //手动发货
    [[VSDKAPI shareAPI] vsdk_PlatformDeliveryWithType:2 AndGoodid:self.codetag Success:^(id responseObject) {
        self.giftView.hidden = YES;
        self.confimView.hidden = YES;
        if (REQUESTSUCCESS) {
            [self updateUI];
            //提示成功
//                VS_SHOW_SUCCESS_STATUS(@"发货成功");
            VS_SHOW_SUCCESS_STATUS(VSLocalString(@"Redeem successfully"));
            [self reloadeMallData];
        }else if([[responseObject objectForKey:@"state"]  isEqual: @103]){
            //提示失败
//                VS_SHOW_ERROR_STATUS(@"积分不够");
            VS_SHOW_ERROR_STATUS(@"Insufficient points");
        }else{
//                VS_SHOW_ERROR_STATUS(@"发货失败");
            VS_SHOW_ERROR_STATUS(@"Redeem failed");
        }
        
            } Failure:^(NSString *errorMsg) {
//                    VS_SHOW_ERROR_STATUS(@"发货失败");
                VS_SHOW_ERROR_STATUS(@"Redeem failed");
            }];
}



-(void)redmeeClick:(UIButton *)btn{
    
    NSLog(@"%@",btn.ChangeType);
    NSLog(@"%@",btn.CodeTags);
    
    if ([btn.ChangeType isEqualToString:@"1"]) {

        [[VSDKAPI shareAPI] vsdk_PlatformDeliveryWithType:1 AndGoodid:btn.CodeTags Success:^(id responseObject) {
                    
            if (REQUESTSUCCESS) {
                NSDictionary * dic = [responseObject objectForKey:@"data"];
                if (dic.count > 0) {
                    NSString *code = dic[@"gift_code"];
                    
                    self.goodid = code;
                    self.giftView.hidden = NO;
//                    self.confimView.hidden = YES;
                    self.giftLabel.text = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Gift Code"),code];
                    //重新赋值view大小
//                    self.giftBtn.CodeTags = code;
                    //计算label的宽度
                    CGFloat w = [VSDeviceHelper sizeWithFontStr:self.giftLabel.text WithFontSize:17];
                    [self.giftView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self.mainView);
                        make.size.mas_equalTo(CGSizeMake(w + 80 + 10, 60));
                    }];
                //    [self.giftView layoutIfNeeded];
                    [self.giftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.giftView.mas_left).offset(20);
                        make.centerY.equalTo(self.giftView);
                        make.size.mas_equalTo(CGSizeMake(w + 10, 50));
                    }];
                    [self.giftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(self.giftView);
                        make.size.mas_equalTo(CGSizeMake(80, 45));
                        make.right.equalTo(self.giftView.mas_right).offset(0);
                    }];
                    
                    
                }
            }else if([[responseObject objectForKey:@"state"]  isEqual: @103]){
                //提示失败
//                VS_SHOW_ERROR_STATUS(@"积分不够");
                VS_SHOW_ERROR_STATUS(@"Insufficient points");
            }else{
//                VS_SHOW_ERROR_STATUS(@"发货失败");
                VS_SHOW_ERROR_STATUS(@"Redeem failed");
            }
            
                } Failure:^(NSString *errorMsg) {
                    
                }];
    }else if ([btn.ChangeType isEqualToString:@"2"]){
        self.codetag = btn.CodeTags;
        self.confimView.hidden = NO;
    }
}

-(void)CPClick:(UIButton *)btn{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.goodid;
//    VS_SHOW_SUCCESS_STATUS(@"已复制到粘贴板");
    VS_SHOW_SUCCESS_STATUS(VSLocalString(@"Copy successfully,Please go to the game to redeem"));
    self.giftView.hidden = YES;
    [self updateUI];
    [self reloadeMallData];
    //刷新积分
}

-(void)updateUI{
    [[VSDKAPI shareAPI] vsdk_initPlatformIntegralWithType:0 Success:^(id responseObject) {
        
        if (REQUESTSUCCESS) {
            NSLog(@"%@",responseObject);
            NSDictionary * dic = [responseObject objectForKey:@"data"];
            if (dic.count > 0) {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setValue:dic forKey:@"PLT_INIT"];
                [ud synchronize];
            
                IntergralModel *model = [IntergralModel sharModel];
                model.curtime = dic[@"cur_time"];
                model.idescription = dic[@"description"];
                model.hot_dot = [dic[@"hot_dot"] stringValue];
                model.point_clear_time = dic[@"point_clear_time"];
                model.pay_time = dic[@"pay_time"];
                
//                    model.pay_time = @"16630386181";
                
                model.sign_time = dic[@"sign_time"];
                model.user_point = dic[@"user_point"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEUI" object:nil];
            }
            
        }
        
            } Failure:^(NSString *errorMsg) {
                
            }];
}

-(void)closeAllView{
    [SDKENTRANCE resignWindow];
    [[VSDKHelper sharedHelper] showAssistant];
    [[VSDKHelper sharedHelper] assistantBtnClick];
}

@end
