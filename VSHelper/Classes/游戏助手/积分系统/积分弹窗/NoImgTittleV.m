//
//  NoImgTittleV.m
//  VVSDK
//
//  Created by admin on 9/15/22.
//
#import "Masonry.h"
#import "VSSDKDefine.h"
#import "VSDKHelper.h"
#import "SDKENTRANCE.h"
#import "NoImgTittleV.h"

@interface NoImgTittleV()
@property (nonatomic,strong) UIView *centerV;
@property (nonatomic,strong) UIImageView *imgV;

@property (nonatomic,strong) UIButton *gobackBtn;
@end

@implementation NoImgTittleV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.centerV = [[UIView alloc] init];
        self.windowTitle = [[UILabel alloc] init];
        self.imgV = [[UIImageView alloc] init];
        self.gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.centerV];
        [self addSubview:self.gobackBtn];
        [self.centerV addSubview:self.imgV];
        [self.centerV addSubview:self.windowTitle];
        
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        self.windowTitle.textAlignment = NSTextAlignmentLeft;
        self.windowTitle.textColor = [UIColor whiteColor];
        [self.gobackBtn setImage:[UIImage imageNamed:kSrcName(@"Iback")] forState:UIControlStateNormal];
        [self.gobackBtn addTarget:self action:@selector(gobackClick) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = VS_RGB(255, 157, 0);
       
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelW = [VSDeviceHelper sizeWithFontStr:self.windowTitle.text WithFontSize:17];
    
    [self.gobackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerY.equalTo(self);
    }];
    [self.centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(labelW + 25, self.frame.size.height));
    }];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.centerV.mas_centerX).offset(-20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self.centerV);
        make.left.equalTo(self.centerV.mas_left);
    }];
    [self.windowTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imgV.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(labelW, self.frame.size.height));
    }];
}


-(void)gobackClick{
   
}

@end
