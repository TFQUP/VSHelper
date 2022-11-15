//
//  VSTipsView.m
//  VSDK
//
//  Created by admin on 7/2/21.
//

#import "VSTipsView.h"
#import "VSSDKDefine.h"
@implementation VSTipsView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
       
        self.layer.masksToBounds = YES;
    }
    
    return self;
}


-(void)showTipsViewWithBlock:(tipsBlock)block{
    
    self.block = [block copy];
    self.socialBgView = [[UIView alloc]initWithFrame:VS_RootVC.view.bounds];
    self.socialBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];

    self.frame =isPad?DEVICEPORTRAIT?CGRectMake(20, 30, 414 * 4/5, (414*4/5.5)/1.4):CGRectMake(20, 30, (414*3.5/5)*1.2, 414* 3.5/6):DEVICEPORTRAIT?CGRectMake(20, 30, SCREE_WIDTH * 4/5, (SCREE_WIDTH*4/5.5)/1.4):CGRectMake(20, 30, (SCREE_HEIGHT*3.5/5)*1.2, SCREE_HEIGHT* 3.5/6);
    
    self.layer.cornerRadius = 10;
    self.backgroundColor = VS_RGB(242, 244, 245);
    self.center = VS_RootVC.view.center;
    [self.socialBgView addSubview:self];
    [VS_RootVC.view addSubview:self.socialBgView];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).with.offset(45);
        make.right.equalTo(self.mas_right).with.offset(-40);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 45));
    }];
    
    titleLabel.text =VSLocalString(@"Notice");
    titleLabel.textColor = VSDK_ORANGE_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    

    UIButton * closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
         
         [self addSubview:closebtn];
         
         [closebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (DEVICEPORTRAIT) {
              
             make.top.equalTo(self.mas_top).with.offset(10);
             make.right.equalTo(self.mas_right).with.offset(-15);
             make.size.mas_equalTo(CGSizeMake(32, 32));
    
            }else{
                
             make.top.equalTo(self.mas_top).with.offset(10);
             make.right.equalTo(self.mas_right).with.offset(-10);
             make.size.mas_equalTo(CGSizeMake(32, 32));
                
            }
             
         }];
      
         [closebtn setBackgroundImage:[UIImage imageNamed:kSrcName(@"vsdk_close")] forState:UIControlStateNormal];
         [closebtn addTarget:self action:@selector(closeAlertView:) forControlEvents:UIControlEventTouchUpInside];
         
   

        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cancelBtn];
         
         [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {

             make.bottom.equalTo(self.mas_bottom).with.offset(-20);
             make.left.equalTo(self.mas_left).with.offset(30);
             make.size.mas_equalTo(CGSizeMake((self.frame.size.width - 90)/2, 40));

         }];
      
        [cancelBtn setTitle:VSLocalString(@"Cancel") forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:kSrcName(@"vsdk_cliamed_btn_bg")] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:VSDK_GRAY_COLOR forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClicK:) forControlEvents:UIControlEventTouchUpInside];
         
    
        UIButton * comfireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:comfireBtn];
         
         [comfireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
    
             make.bottom.equalTo(self.mas_bottom).with.offset(-20);
             make.right.equalTo(self.mas_right).with.offset(-30);
             make.size.mas_equalTo(CGSizeMake((self.frame.size.width - 90)/2, 40));

         }];
       
        [comfireBtn setTitle:VSLocalString(@"OK") forState:UIControlStateNormal];
        [comfireBtn setBackgroundImage:[UIImage imageNamed:kSrcName(@"vsdk_receive_btn_bg")] forState:UIControlStateNormal];
        [comfireBtn addTarget:self action:@selector(comfireBtnClicK:) forControlEvents:UIControlEventTouchUpInside];
             
    
    UILabel * infoLabel = [[UILabel alloc]init];
       
       [self addSubview:infoLabel];
       
       [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         
           if (DEVICEPORTRAIT) {
           make.top.equalTo(closebtn.mas_bottom).with.offset(10);
           make.left.equalTo(self.mas_left).with.offset(20);
           make.right.equalTo(self.mas_right).with.offset(-20);
           make.bottom.equalTo(comfireBtn.mas_top).with.offset(-10);
               
           }else{
           make.top.equalTo(closebtn.mas_bottom).with.offset(20);
           make.left.equalTo(self.mas_left).with.offset(20);
           make.right.equalTo(self.mas_right).with.offset(-20);
           make.bottom.equalTo(comfireBtn.mas_top).with.offset(-20);
           }
       }];

        infoLabel.font = DEVICEPORTRAIT?[UIFont systemFontOfSize:15]:[UIFont systemFontOfSize:18];
        infoLabel.textColor = VSDK_GRAY_COLOR;
        infoLabel.textAlignment = NSTextAlignmentCenter;

        infoLabel.text =VSLocalString(@"Click OK to hide the floating button till next time you start the game");
        infoLabel.numberOfLines = 0;
    
    
     [VSDeviceHelper addAnimationInView:self Duration:0.5];
}



-(void)comfireBtnClicK:(UIButton *)sender{
    
    if (self.block) {
        
        self.block(YES);
    }
    
}

-(void)cancelBtnClicK:(UIButton *)sender{
    
    if (self.block) {
          
        self.block(NO);
       }
    
}


-(void)closeAlertView:(UIButton *)sender{
    
    [self.socialBgView  removeFromSuperview];
    [self removeFromSuperview];
    
    
}
@end
