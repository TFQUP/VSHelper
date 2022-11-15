//
//  ActiveVC.m
//  VVSDK
//
//  Created by admin on 8/25/22.
//

#import "ActiveVC.h"
#import "Masonry.h"
#import "VSSDKDefine.h"
#import "SDKENTRANCE.h"
#import "VSDKHelper.h"
#import "IntergralModel.h"
@interface ActiveVC ()<WKNavigationDelegate>
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) UIView *topV;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) WKWebView *textView;
@property(nonatomic,strong) UIButton *closeBtn;

@property (nonatomic,strong) UIButton *closeVBtn;
//@property(nonatomic,strong) WKWebView *wk;
@end

@implementation ActiveVC

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
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(UIView *)topV{
    if (_topV == nil) {
        _topV = [[UIView alloc] init];
        _topV.backgroundColor = VS_RGB(255, 157, 0);
        _titleLabel = [[UILabel alloc] init];
        [_topV addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"活动规则";
        _titleLabel.text = VSLocalString(@"Rules");
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _topV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.closeVBtn];
    self.textView = [[WKWebView alloc] init];
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mainView addSubview:self.topV];
    [self.mainView addSubview:self.textView];
    [self.mainView addSubview:self.closeBtn];
//    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn setTitle:VSLocalString(@"Close") forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(resignWindowClick) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn.backgroundColor = VS_RGB(255, 157, 0);
    self.closeBtn.layer.cornerRadius = 8;
    [self setUI];
//    self.textView.userInteractionEnabled = NO;
//    self.textView.font = [UIFont systemFontOfSize:14];
//    self.textView.text = @"1.XXXXXXXXXX\n2.XXXXXXXXXXXX\n3.XXXXXXXX\n";
    NSString *activeStr = [IntergralModel sharModel].idescription;
    self.textView.navigationDelegate = self;
    [self.textView loadHTMLString:activeStr baseURL:nil];
    self.textView.scrollView.showsVerticalScrollIndicator = NO;
}

-(void)setUI{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        if(DEVICEPORTRAIT){
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.85, self.view.frame.size.height * 0.5));
        }else{
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width * 0.7, self.view.frame.size.height * 0.7));
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
    
    [self.topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top);
        make.left.equalTo(self.mainView.mas_left);
        make.right.equalTo(self.mainView.mas_right);
        make.height.mas_equalTo(45);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.topV);
        make.center.equalTo(self.topV);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mainView);
        make.size.mas_equalTo(CGSizeMake(130, 40));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topV.mas_bottom);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.right.equalTo(self.mainView.mas_right).offset(-10);
        make.bottom.equalTo(self.closeBtn.mas_top).offset(-10);
    }];
    
}

-(void)resignWindowClick{
    [[VSDKHelper sharedHelper] showAssistant];
    [SDKENTRANCE resignWindow];
}

// WKNavigationDelegate 页面加载完成之后调用

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //修改字体大小 300%
    
    if (DEVICEPORTRAIT) {
        [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '320%'"completionHandler:nil];
    }else{
        [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    }
    
}

-(void)closeAllView{
    [SDKENTRANCE resignWindow];
    [[VSDKHelper sharedHelper] showAssistant];
    [[VSDKHelper sharedHelper] assistantBtnClick];
}
@end
