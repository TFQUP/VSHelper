//
//  IntegralDetailVC.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "IntegralDetailVC.h"
#import "TitleView.h"
#import "Masonry.h"
#import "DetailCell.h"
#import "VSSDKDefine.h"
#import "SDKENTRANCE.h"

@interface IntegralDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) TitleView *titleV;
@property (nonatomic,strong) UITableView *tabV;
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) UIButton *closeVBtn;
@end

@implementation IntegralDetailVC

-(UIButton *)closeVBtn{
    if (_closeVBtn == nil) {
        _closeVBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeVBtn setImage:[UIImage imageNamed:kSrcName(@"vsdk_outside_close.png")] forState:UIControlStateNormal];
        [_closeVBtn addTarget:self action:@selector(closeAllView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeVBtn;
}

-(UIView *)mainView{
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 10;
    }
    return _mainView;
}

-(TitleView *)titleV{
    if (_titleV == nil) {
        _titleV = [[TitleView alloc] initWithFrame:CGRectZero];
        _titleV.JFSTATE = JFMX;
    }
    return _titleV;
}

-(UITableView *)tabV{
    if (_tabV == nil) {
        _tabV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tabV.delegate = self;
        _tabV.dataSource = self;
    }
    return _tabV;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[VSDKAPI shareAPI] vsdk_initPlatformIntegralWithType:2 Success:^(id responseObject) {
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
    [self setUI];
}

-(void)setUI{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        if(DEVICEPORTRAIT){
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.88, self.view.frame.size.height * 0.5));
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
        make.bottom.equalTo(self.mainView.mas_bottom);
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [DetailCell detailCellWithTableView:tableView];
//    cell.productLabel.text = @"超级牛肉丸*100";
//    cell.priceLabel.text = @"+1000";
    cell.productLabel.text = self.dataArr[indexPath.row][@"gift_name"];
    NSInteger type = [self.dataArr[indexPath.row][@"type"] integerValue];
    NSString *coinStr = @"";
    if (type == 1) {
        coinStr = [NSString stringWithFormat:@"+%@",self.dataArr[indexPath.row][@"point"]];
    }else if (type == 2){
        coinStr = [NSString stringWithFormat:@"-%@",self.dataArr[indexPath.row][@"point"]];
    }
    cell.priceLabel.text = coinStr;
    return cell;
}

-(void)closeAllView{
    [SDKENTRANCE resignWindow];
    [[VSDKHelper sharedHelper] showAssistant];
    [[VSDKHelper sharedHelper] assistantBtnClick];
}
@end
