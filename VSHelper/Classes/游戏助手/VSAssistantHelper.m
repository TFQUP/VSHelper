//
//  VSAssistantHelper.m
//  VSDK
//
//  Created by admin on 7/2/21.
//

#import "VSDKAPI.h"
#import "VSAssistantHelper.h"
#import "IntergralModel.h"
#import "VSDKHelper.h"
@interface VSAssistantHelper ()

@property(strong,nonatomic)VSAssistantView * assitantView;

@end

@implementation VSAssistantHelper

-(UIView *)backV{
    if (_backV == nil) {
        _backV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backV.backgroundColor = [UIColor clearColor];
    }
    return _backV;
}

-(VSAssistantView *)assitantView{
    
    if (!_assitantView) {
        _assitantView = [[VSAssistantView alloc]initWithFrame:DEVICEPORTRAIT? CGRectMake(20, 30, 0, 30):CGRectMake(20, 30, 0, 50)];
        _assitantView.layer.zPosition = MAXFLOAT;

    }
    
    return _assitantView;
}

-(VSBadgeBtn *)assitantBtn{
    
    if (!_assitantBtn) {
        
        _assitantBtn = [VSBadgeBtn buttonWithType:UIButtonTypeCustom];
        _assitantBtn.alpha = 0.6;
        _assitantBtn.frame = isPad?DEVICEPORTRAIT?CGRectMake(-15, 35, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT):CGRectMake(-15, 35, 65*SCREE_HEIGHT/1024, 65*SCREE_HEIGHT/1024):DEVICEPORTRAIT?CGRectMake(-15, 35, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT):CGRectMake(-15, 35, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH);
        
        [_assitantBtn setImage:[UIImage imageNamed:kSrcName(@"vsdk_assistant_ball")] forState:UIControlStateNormal];
        
        
        [_assitantBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(btnMoved:)];
        [_assitantBtn addGestureRecognizer:pan];
        _assitantBtn.layer.zPosition = MAXFLOAT;
        
    }
    
    return _assitantBtn;
}

-(void)vsdk_assistantToolShowInVc:(UIViewController *)vc{
    
    if (!VSDK_DIC_WITH_PATH(VSDK_ASSISTANT_CONFIG_PATH))  return;
    
    [vc.view addSubview:self.backV];
    self.backV.hidden = YES;
    [vc.view addSubview:self.assitantView];
    
    //判断是否显示角标
    if ([self assistantShowAlert]) {
        
        [self floatBtnShowBaderAlert];
    }
    
    [vc.view addSubview:self.assitantBtn];
    
//    if (!_assitantBtn) {
//
//        self.assitantBtn = [VSBadgeBtn buttonWithType:UIButtonTypeCustom];
//        self.assitantBtn.alpha = 0.6;
//        self.assitantBtn.frame = isPad?DEVICEPORTRAIT?CGRectMake(-15, 35, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT):CGRectMake(-15, 35, 65*SCREE_HEIGHT/1024, 65*SCREE_HEIGHT/1024):DEVICEPORTRAIT?CGRectMake(-15, 35, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT):CGRectMake(-15, 35, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH);
//
//        [self.assitantBtn setImage:[UIImage imageNamed:kSrcName(@"vsdk_assistant_ball")] forState:UIControlStateNormal];
//
//        if ([self assistantShowAlert]) {
//
//            [self floatBtnShowBaderAlert];
//        }
        
//        [self.assitantBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(btnMoved:)];
//        [self.assitantBtn addGestureRecognizer:pan];
//        [vc.view addSubview:self.assitantBtn];

//    }else{
        
//        [vc.view addSubview:self.assitantBtn];
//    }
    
}


-(BOOL)assistantShowAlert{
    
    if (([VS_USERDEFAULTS_GETVALUE(VSDK_ASSISTANT_BIND_MAIL) length]==0&&[VS_USERDEFAULTS_GETVALUE(VSDK_ASSISTANT_BIND_PHOME) length]==0)||[[[[[[VSDeviceHelper preSaveSocialData]objectForKey:@"fivestar_event"]objectForKey:@"list"]firstObject]objectForKey:@"item_event_state"] isEqual:@0]||[VS_USERDEFAULTS_GETVALUE(@"vsdk_red_packet_state") isEqual:@1] || [IntergralModel sharModel].isHot_dot) {

        return YES;

    }else{

        return NO;
    }
    
//    if ([IntergralModel sharModel].isHot_dot) {
//        return YES;
//    }else{
//        return NO;
//    }
 
}

-(void)floatBtnShowBaderAlert{
    
    if (!self.assitantBtn.showBadge) {
        [self.assitantBtn setBadgeImage:kSrcName(@"vsdk_alert")];
        [self.assitantBtn setShowBadge:YES];
    }
}


-(void)buttonClicked:(VSBadgeBtn *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //设置背景不可点
        [[VSDKHelper sharedHelper] showBackV];
        //平台积分初始化
        if ([IntergralModel sharModel].point_state) {
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
        
        sender.alpha = 0.9;
        
        [UIView animateWithDuration:0.15 animations:^{
          self.assitantBtn.badgeAlertImageView.transform = CGAffineTransformMakeScale(0, 0);
            sender.frame =DEVICEPORTRAIT?CGRectMake(10, sender.frame.origin.y, 1.5* sender.frame.size.width, 1.5* sender.frame.size.height):CGRectMake(10, sender.frame.origin.y,1.4*  sender.frame.size.width, 1.4 * sender.frame.size.height);
 
            [self.assitantView showAssitantViewWithSender:sender ResultBlock:^(BOOL result, UIButton *clickedBtn) {
                
                [self closeAstAfterClickedFuncBtn:clickedBtn];
       
            }];
            
        } completion:^(BOOL finished) {
            
            [self.assitantBtn.badgeAlertImageView removeFromSuperview];
            
        }];
        
    }else{
        [[VSDKHelper sharedHelper] hideBackV];
//        [self.assitantView.integralView removeFromSuperview];
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            sender.alpha = 0.5;
            sender.frame = isPad? DEVICEPORTRAIT?CGRectMake(-15, sender.frame.origin.y, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT):CGRectMake(-15, sender.frame.origin.y, 65*SCREE_HEIGHT/1024, 65*SCREE_HEIGHT/1024):DEVICEPORTRAIT?CGRectMake(-15, sender.frame.origin.y, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT):CGRectMake(-15, sender.frame.origin.y, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH);
                    
            for (UIView * subViews in self.assitantView.subviews) {
                
                [subViews removeFromSuperview];
            }
            self.assitantView.frame = DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y,0,35):  CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y,0,50) ;
            
        } completion:^(BOOL finished) {
            
            
        if ([self assistantShowAlert]) {
                    
                [sender setBadgeImage:kSrcName(@"vsdk_alert")];
                [sender setShowBadge:YES];
                     
            }
            sender.userInteractionEnabled = YES;
            
        }];
        
    }
    
}


/// 按钮移动
/// @param recognizer 识别器
-(void)btnMoved:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        recognizer.view.alpha = 1;
        
        [UIView animateWithDuration:0.15 animations:^{
            
            for (UIView * subViews in self.assitantView.subviews) {
                
                [subViews removeFromSuperview];
            }
            
            self.assitantView.frame = CGRectMake(recognizer.view.center.x,recognizer.view.center.y,0,0) ;
            
        }];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        
        recognizer.view.center = [recognizer locationInView:recognizer.view.superview];
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded ){
        
        [UIView animateWithDuration:0.3 delay:0.3 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            if(((UIButton *)recognizer.view).selected) {
                
                ((UIButton *)recognizer.view).selected = NO;
                recognizer.view.alpha = 0.5;
                recognizer.view.frame =DEVICEPORTRAIT?CGRectMake(-15, [recognizer locationInView:recognizer.view.superview].y-recognizer.view.frame.size.height/2, recognizer.view.frame.size.width/1.65, recognizer.view.frame.size.height/1.65): CGRectMake(-15, [recognizer locationInView:recognizer.view.superview].y-recognizer.view.frame.size.height/2, recognizer.view.frame.size.width/1.5, recognizer.view.frame.size.height/1.5);
                
            }else{
                
                recognizer.view.alpha = 0.5;
                recognizer.view.frame = CGRectMake(-15, [recognizer locationInView:recognizer.view.superview].y - recognizer.view.frame.size.height/2, recognizer.view.frame.size.width, recognizer.view.frame.size.height);
                
            }
            
                self.assitantView.frame = DEVICEPORTRAIT? CGRectMake(recognizer.view.frame.origin.x+ recognizer.view.frame.size.width/2,recognizer.view.frame.origin.y,0,30): CGRectMake(recognizer.view.frame.origin.x+ recognizer.view.frame.size.width/2,recognizer.view.frame.origin.y,0,50) ;
            
            
        } completion:^(BOOL finished) {}];
    }
}


#pragma mark -- 各小助手模块点击事件
-(void)closeAstAfterClickedFuncBtn:(UIButton *)sender{
    
    self.assitantBtn.selected = !self.assitantBtn.selected;

        [UIView animateWithDuration:0.15 animations:^{
        
        for (UIView * subViews in self.assitantView.subviews) {
           [subViews removeFromSuperview];
        }

        self.assitantBtn.frame = isPad?DEVICEPORTRAIT?CGRectMake(-15, self.assitantBtn.frame.origin.y, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT, 60*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT): CGRectMake(-15, self.assitantBtn.frame.origin.y, 65*SCREE_HEIGHT/1024, 65*SCREE_HEIGHT/1024):DEVICEPORTRAIT?CGRectMake(-15, self.assitantBtn.frame.origin.y, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT, 40*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT):CGRectMake(-15, self.assitantBtn.frame.origin.y, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH, 45*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH);

        self.assitantBtn.userInteractionEnabled = YES;
            
        if ([self assistantShowAlert]) {
            [self floatBtnShowBaderAlert];
        }
            
        self.assitantView.frame = DEVICEPORTRAIT?CGRectMake(VS_VIEW_LEFT(self.assitantBtn)+ self.assitantBtn.frame.size.width/2,self.assitantBtn.frame.origin.y,0,self.assitantBtn.frame.size.height): CGRectMake(VS_VIEW_LEFT(self.assitantBtn)+ self.assitantBtn.frame.size.width/2,self.assitantBtn.frame.origin.y,0,self.assitantBtn.frame.size.height) ;
        
    }completion:^(BOOL finished) {
      
        self.assitantBtn.alpha = 0.5;
    }];
    
    NSString *bulletinStr = @"Bulletin";
    if ([self isKorean]) {
        bulletinStr = @"게시판";
    }else{
        bulletinStr = VSLocalString(@"Bulletin");
    }
    
    if ([sender.titleLabel.text isEqualToString:VSLocalString(@"Event")]) {
        
        VSEventView * event = [[VSEventView alloc]init] ;
        event.webUrl = [VSDK_DIC_WITH_PATH(VSDK_ASSISTANT_CONFIG_PATH) objectForKey:@"game_event_url"] != nil ? [VSDK_DIC_WITH_PATH(VSDK_ASSISTANT_CONFIG_PATH) objectForKey:@"game_event_url"]:@"https://www.unlock.game";
        [event vsdk_eventViewShow];
                
    }else if ([sender.titleLabel.text isEqualToString:bulletinStr]) {

        VSNormalBulltein * view = [[VSNormalBulltein alloc]initWithFrame:DEVICEPORTRAIT?CGRectMake(0, 0, SCREE_WIDTH - 60, SCREE_HEIGHT /2): CGRectMake(0, 0, SCREE_WIDTH *2/3, SCREE_HEIGHT - 60)];
        view.center = VS_RootVC.view.center;
        [VS_RootVC.view addSubview:view];
                
    }else if ([sender.titleLabel.text isEqualToString:VSLocalString(@"Account")]) {

        VSAssitButton * btn = (VSAssitButton *)sender;
        [btn.badgeAlertImageView removeFromSuperview];
        VSUserCenterEntrance * view = [[VSUserCenterEntrance alloc]init];
        [view vsdk_setUpCenterEntrance];
        
    }else if ([sender.titleLabel.text isEqualToString:VSLocalString(@"Website")]){

        [VSDeviceHelper showTermOrContactCustomerServiceWithUrl:VSDK_LOCAL_DATA(VSDK_ASSISTANT_CONFIG_PATH, @"game_website_url")?VSDK_LOCAL_DATA(VSDK_ASSISTANT_CONFIG_PATH, @"game_website_url"):@"https://www.unlock.game"];
        
    }else if ([sender.titleLabel.text isEqualToString:VSLocalString(@"Facebook")]){
        
        [VSDKShareHelper vsdk_openWebsiteWithUrl:VSDK_LOCAL_DATA(VSDK_ASSISTANT_CONFIG_PATH, @"facebook_page_url")?VSDK_LOCAL_DATA(VSDK_ASSISTANT_CONFIG_PATH, @"facebook_page_url"):VSDK_FB_LIKE_PAGE_URL inCurrentVc:VS_RootVC];
   
    }else if([sender.titleLabel.text isEqualToString:VSLocalString(@"Rating")]){
        
        VSAssitButton * btn = (VSAssitButton *)sender;
        [btn.badgeAlertImageView removeFromSuperview];
        [[[VSFiveStarView alloc]init] vsdk_requeustMarkReview];
  
    }else if([sender.titleLabel.text isEqualToString:VSLocalString(@"Share")]){
      
        [VSDKShareHelper vsdk_showSocialSharePage];
  
    }else if([sender.titleLabel.text isEqualToString:VSLocalString(@"Support")]){
 
        [VSDeviceHelper showTermOrContactCustomerServiceWithUrl:[VSDeviceHelper vsdk_customServiceUrl]];
        
    }else if([sender.titleLabel.text isEqualToString:VSLocalString(@"Red Packet")]){
        
        VSEventView * redPacket = [[VSEventView alloc]init] ;
        redPacket.webUrl = [[NSString stringWithFormat:@"%@?%@",[VSDK_DIC_WITH_PATH(VSDK_ASSISTANT_CONFIG_PATH) objectForKey:@"red_bag_url"],[VSDeviceHelper getBasicRequestWithParams:@{VSDK_PARAM_SERVER_ID:VS_USERDEFAULTS_GETVALUE(VSDK_SOCIAL_SERVER_ID),VSDK_PARAM_SERVER_NAME:VS_USERDEFAULTS_GETVALUE(VSDK_SOCIAL_SERVER_NAME),VSDK_PARAM_ROLE_ID:VS_USERDEFAULTS_GETVALUE(VSDK_SOCIAL_ROLE_ID),VSDK_PARAM_ROLE_NAME:VS_USERDEFAULTS_GETVALUE(VSDK_SOCIAL_ROLE_NAME),VSDK_PARAM_ROLE_LEVEL:VS_USERDEFAULTS_GETVALUE(VSDK_SOCIAL_ROLE_LEVEL),VSDK_PARAM_UUID:[[VSDeviceHelper vsdk_realAdjustIdfa]length]>0?[VSDeviceHelper vsdk_realAdjustIdfa]:[VSDeviceHelper vsdk_keychainIDFA],VSDK_PARAM_TOKEN:VS_USERDEFAULTS_GETVALUE(VSDK_LEAST_TOKEN_KEY)}]]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ;
    
        [redPacket vsdk_eventViewShow];
 
    } else{
        
        VSTipsView * alert = [[VSTipsView alloc]init];
          [alert showTipsViewWithBlock:^(BOOL hide) {
              
              if (hide) {
                  
                  [alert removeFromSuperview];
                  [alert.socialBgView removeFromSuperview] ;
                  [self.assitantBtn removeFromSuperview];
  
              }else{
                
                  [alert removeFromSuperview];
                  [alert.socialBgView removeFromSuperview];
              }
              
        }];
    }
}

-(BOOL)isKorean{
    NSArray *languages = [NSLocale preferredLanguages];
    if (languages.count>0) {
       NSString *currentLocaleLanguageCode = languages.firstObject;
        if ([currentLocaleLanguageCode hasPrefix:@"ko"]) {
            return YES;
        }
    }
    return NO;
}

-(void)assistantShow{
    self.assitantBtn.hidden = NO;
    self.assitantView.hidden = NO;
}

-(void) assitantHide{
    self.assitantBtn.hidden = YES;
    self.assitantView.hidden = YES;
}

-(void)assitantClick{
    [self buttonClicked:self.assitantBtn];
}
@end
