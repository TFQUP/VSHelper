//
//  VSAssistantView.m
//  VSDK
//
//  Created by admin on 7/2/21.
//


#import "VSAssistantView.h"
#import "VSSDKDefine.h"
#import "IntergralModel.h"
static CGFloat const kButtonHeight = 50.75 * 0.8;
static CGFloat const kButtonWidth = 38.25 * 0.8;
static CGFloat const kPadButtonHeight = 65.f;
static CGFloat const kPadButtonWidth = 51.f;
static CGFloat const kHeightSpace = 8.f * 0.8;//竖间距
static CGFloat const kButtonPoritatHeight = 46 * 0.8;
//static CGFloat const kButtonPoritatWidth = 34.f * 0.8;
//static CGFloat const kButtonPadPoritatHeight = 61.62f;

static CGFloat const kButtonPoritatWidth = 45.f * 0.8;
static CGFloat const kButtonPadPoritatHeight = 65.00f;

static CGFloat const kButtonPadPoritatWidth = 48.36f;
static CGFloat const kHeightPoritatSpace = 6.f * 0.8;


@interface VSAssistantView ()
@property(nonatomic,strong)NSMutableArray * featuresArray;
@property(nonatomic,copy)void(^resultBlock)(BOOL result,UIButton * sender);
@property(nonatomic,assign)CGFloat AssitantViewheight;//分享视图的高度
@property(nonatomic,assign)NSUInteger columnCount;


@property (nonatomic,strong) UIView *backV;

@end

@implementation VSAssistantView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.layer.borderColor = VSDK_ORANGE_COLOR.CGColor;
        self.layer.borderWidth = DEVICEPORTRAIT?1.5:1.8;
        
    }
    return self;
}


-(IntegralView *)integralView{
    if (_integralView == nil) {
        _integralView = [[IntegralView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
//        _integralView.backgroundColor = [UIColor redColor];
        _integralView.layer.cornerRadius = 10;
    }
    return _integralView;
}

-(void)showAssitantViewWithSender:(UIButton *)sender ResultBlock:(void(^)(BOOL result,UIButton *clickedBtn))result{
    
    self.resultBlock = [result copy];
    [self setUpFeaturesWithsSuperView:sender];
    
}


-(void)setUpFeaturesWithsSuperView:(UIButton *)sender{
    //底部背景
    self.backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    if ([IntergralModel sharModel].point_state) {
        [self addSubview:self.backV];
    }
   
    NSDictionary * assistantDic = VSDK_DIC_WITH_PATH(VSDK_ASSISTANT_CONFIG_PATH);
    
    NSArray * moduleSort = [assistantDic objectForKey:@"sort"];
    
    NSDictionary * moduleDic  = @{@"game_event":@[@"vsdk_event",@"Event"],@"user_center":@[@"vsdk_user_center",@"Account"],@"red_bag":@[@"white_packet",@"Red Packet"],@"game_website":@[@"vsdk_website",@"Website"],@"facebook_page":@[@"vsdk_fb_home_page",@"Facebook"],@"fivestar_praise":@[@"vsdk_praise",@"Rating"],@"gam_gift":@[@"vsdk_share",@"Share"],@"customer_service":@[@"vsdk_contact",@"Support"],@"notice":@[@"vsdk_floatview_menu_bulletin",@"Bulletin"],@"hide_floatball":@[@"vsdk_hide",@"Hide"]};
    
    self.featuresArray = [NSMutableArray array];
    
    for (NSString * mudule in moduleSort) {
        
        if ([[assistantDic objectForKey:[NSString stringWithFormat:@"%@_state",mudule]] isEqual:@1]) {
            
            VSFeatures * feature = [[VSFeatures alloc] init];
            feature.iconNormal = kSrcName([[moduleDic objectForKey:mudule] firstObject]);
            NSLog(@"%@",[[moduleDic objectForKey:mudule] lastObject]);
            
            feature.name =VSLocalString([[moduleDic objectForKey:mudule] lastObject]);
            
            NSString *bulletinStr = @"Bulletin";
            if ([bulletinStr isEqualToString:[[moduleDic objectForKey:mudule] lastObject]]) {
                if ([VSTool isKorean]) {
                    bulletinStr = @"게시판";
                    feature.name = bulletinStr;
                }else{
                    bulletinStr = VSLocalString(@"Bulletin");
                    feature.name =VSLocalString([[moduleDic objectForKey:mudule] lastObject]);
                }
               
            }
            
            NSString *EventStr = @"Event";
            if ([EventStr isEqualToString:[[moduleDic objectForKey:mudule] lastObject]]) {
                if ([VSTool isKorean]) {
                    EventStr = @"이벤트";
                    feature.name = EventStr;
                }else{
                    EventStr = VSLocalString(@"Event");
                    feature.name =VSLocalString([[moduleDic objectForKey:mudule] lastObject]);
                }
               
            }
            
            NSString *RedStr = @"Red Packet";
            if ([RedStr isEqualToString:[[moduleDic objectForKey:mudule] lastObject]]) {
                if ([VSTool isKorean]) {
                    RedStr = @"럭키 봉투";
                    feature.name = RedStr;
                }else{
                    RedStr = VSLocalString(@"Red Packet");
                    feature.name =VSLocalString([[moduleDic objectForKey:mudule] lastObject]);
                }
               
            }

            [self.featuresArray addObject:feature];
        }
    }
    
    
    if (DEVICEPORTRAIT) {
        
        if (kiPhone5) {
            
            self.columnCount = self.featuresArray.count >4?4:self.featuresArray.count;

        }else{
            
            if (isPad) {
              
                self.columnCount = self.featuresArray.count >7?7:self.featuresArray.count;
                
            }else{
                
                self.columnCount = self.featuresArray.count >5?5:self.featuresArray.count;
            }
        }
        
    }else{
        
        self.columnCount = self.featuresArray.count >9?9:self.featuresArray.count;
        
    }
    
    CGFloat marginTimes;
    
    if (self.featuresArray.count <= self.columnCount){
        
        marginTimes = 2.3;
        
    }else{
        
        if (DEVICEPORTRAIT) {
            
            marginTimes =  ((self.featuresArray.count/self.columnCount) + 1.6)*2;
            
        }else{
                
            
            marginTimes =  (self.featuresArray.count/self.columnCount) == 1? 3:2;
            
        }
        
    }
    //计算view的高度
    self.AssitantViewheight = isPad?DEVICEPORTRAIT?kHeightPoritatSpace * (marginTimes) +kButtonPadPoritatHeight*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT + kButtonPadPoritatHeight*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT * (self.featuresArray.count/(self.columnCount+1)):kHeightSpace * 2 +kPadButtonHeight * SCREE_HEIGHT/1024:DEVICEPORTRAIT?kHeightPoritatSpace * (marginTimes) +kButtonPoritatHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT + kButtonPoritatHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT * (self.featuresArray.count/(self.columnCount+1)) :kHeightSpace * marginTimes + (kButtonHeight * SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH * (self.featuresArray.count%self.columnCount >0 ? 2:1) ) ;
    

    
    CGFloat appMargin = DEVICEPORTRAIT?25:38;
    for (int i = 0; i < self.featuresArray.count; i++) {
        
        VSFeatures * features = self.featuresArray[i];
        //计算列号和行号
        int colX=i%self.columnCount;
        int rowY=i/self.columnCount;
        //计算坐标
        CGFloat buttonX;CGFloat buttonY;
        if ([IntergralModel sharModel].point_state) {
            if (DEVICEPORTRAIT) {
                
                if (isPad) {
                    
                    buttonX = 0 +appMargin+colX*(kButtonPadPoritatWidth * SCREE_WIDTH/1024+appMargin);
                    buttonY = kHeightPoritatSpace*(rowY + 1) +rowY*(kButtonPadPoritatHeight*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT+kHeightPoritatSpace*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT  *self.featuresArray.count/(self.columnCount+1));
                    
                }else{
                    
                    buttonX = 0 +appMargin+colX*(kButtonPoritatWidth * SCREE_WIDTH/IPHONE_SCREEN_MAX_WIDTH+appMargin);
                    buttonY = kHeightPoritatSpace*(rowY + 1) +rowY*(kButtonPoritatHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT+kHeightPoritatSpace*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT  *self.featuresArray.count/(self.columnCount+1));
                }
                
            }else{
                
                if (isPad) {
                    
                    buttonX = 0 +appMargin+colX*(kPadButtonWidth*SCREE_WIDTH/IPAD_SCREEN_MAX_HEGHT+appMargin);
                    buttonY = kHeightSpace*(rowY + 1)+rowY*(kPadButtonHeight * SCREE_HEIGHT/1024+kHeightSpace);
                    
                }else{
                    
                    
                    if (self.featuresArray.count >9) {
                        
                        buttonX = 0 + appMargin+colX*(kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT+appMargin);
                        buttonY = kHeightSpace *(rowY + 1)+rowY*(kButtonHeight * SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH * (self.featuresArray.count/(self.columnCount + 1) ));
                        
                    }else{
                     
                        buttonX = 0 +appMargin+colX*(kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT+appMargin);
                        buttonY = kHeightSpace*(rowY + 1)+rowY*(kButtonHeight * SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH+kHeightSpace);
                        
                    }
                }
            }
        }else{
            if (DEVICEPORTRAIT) {
                
                if (isPad) {
                    
                    buttonX = 34 +appMargin+colX*(kButtonPadPoritatWidth * SCREE_WIDTH/1024+appMargin);
                    buttonY = kHeightPoritatSpace*(rowY + 1) +rowY*(kButtonPadPoritatHeight*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT+kHeightPoritatSpace*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT  *self.featuresArray.count/(self.columnCount+1));
                    
                }else{
                    
                    buttonX = 20 +appMargin+colX*(kButtonPoritatWidth * SCREE_WIDTH/IPHONE_SCREEN_MAX_WIDTH+appMargin);
                    buttonY = kHeightPoritatSpace*(rowY + 1) +rowY*(kButtonPoritatHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT+kHeightPoritatSpace*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT  *self.featuresArray.count/(self.columnCount+1));
                }
                
            }else{
                
                if (isPad) {
                    
                    buttonX = 25 +appMargin+colX*(kPadButtonWidth*SCREE_WIDTH/IPAD_SCREEN_MAX_HEGHT+appMargin);
                    buttonY = kHeightSpace*(rowY + 1)+rowY*(kPadButtonHeight * SCREE_HEIGHT/1024+kHeightSpace);
                    
                }else{
                    
                    
                    if (self.featuresArray.count >9) {
                        
                        buttonX = 15 + appMargin+colX*(kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT+appMargin);
                        buttonY = kHeightSpace *(rowY + 1)+rowY*(kButtonHeight * SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH * (self.featuresArray.count/(self.columnCount + 1) ));
                        
                    }else{
                     
                        buttonX = 18 +appMargin+colX*(kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT+appMargin);
                        buttonY = kHeightSpace*(rowY + 1)+rowY*(kButtonHeight * SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH+kHeightSpace);
                        
                    }
                }
            }
        }
        
        
        VSAssitButton *shareBut = [[VSAssitButton alloc] init];
        [shareBut setTitle:features.name forState:UIControlStateNormal];
        
        [shareBut setImage:[UIImage imageNamed:features.iconNormal] forState:UIControlStateNormal];
        [shareBut addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
        shareBut.tag = i;
        
        //加上顶部view的高度，这里的200应该是顶部view的高度
        if ([IntergralModel sharModel].point_state) {
            buttonY = buttonY + 150;
        }else{
            buttonY = buttonY;
        }
        
        shareBut.frame =isPad?DEVICEPORTRAIT?CGRectMake(buttonX, buttonY, kButtonPadPoritatWidth* SCREE_WIDTH/1024, kButtonPadPoritatHeight*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT): CGRectMake(buttonX, buttonY, kPadButtonWidth*SCREE_WIDTH/IPAD_SCREEN_MAX_HEGHT, kPadButtonHeight*SCREE_HEIGHT/1024):DEVICEPORTRAIT?CGRectMake(buttonX, buttonY, kButtonPoritatWidth* SCREE_WIDTH/IPHONE_SCREEN_MAX_WIDTH, kButtonPoritatHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT): CGRectMake(buttonX, buttonY, kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT, kButtonHeight*SCREE_HEIGHT/IPHONE_SCREEN_MAX_WIDTH);
        
        if ([shareBut.titleLabel.text isEqualToString:VSLocalString(@"Rating")]&&[[[[[[VSDeviceHelper preSaveSocialData]objectForKey:@"fivestar_event"]objectForKey:@"list"]firstObject]objectForKey:@"item_event_state"] isEqual:@0]) {
            [shareBut setBadgeImage:kSrcName(@"vsdk_alert")];
            
        }
        
        if ([shareBut.titleLabel.text isEqualToString:VSLocalString(@"Account")]&&([VS_USERDEFAULTS_GETVALUE(VSDK_ASSISTANT_BIND_MAIL) length]==0&&[VS_USERDEFAULTS_GETVALUE(VSDK_ASSISTANT_BIND_PHOME) length]==0)) {
            
            [shareBut setBadgeImage:kSrcName(@"vsdk_alert")];
           
        }
        
        
        if ([shareBut.titleLabel.text isEqualToString:VSLocalString(@"Red Packet")]&&[VS_USERDEFAULTS_GETVALUE(@"vsdk_red_packet_state") isEqual:@1]) {
            
            [shareBut setBadgeImage:kSrcName(@"vsdk_alert")];
          
        }
        
        [self addSubview:shareBut];
    }
    
    
    
    if ([IntergralModel sharModel].point_state) {
        [self addSubview:self.integralView];
    }
    
    
    //整体view的高度
    CGFloat topH = 10;
    if ([IntergralModel sharModel].point_state) {
         topH = 150 + 20;
        CGFloat wf = [UIApplication sharedApplication].delegate.window.frame.size.width * 0.9;
        
        self.frame = isPad?DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH):DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight  + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH);
    }else{
        self.frame = isPad?DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+27*(self.columnCount + 1) + self.columnCount* kButtonPadPoritatWidth* SCREE_WIDTH/1024 + 10, self.AssitantViewheight + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+38*(self.featuresArray.count + 1) + self.featuresArray.count * kPadButtonWidth*SCREE_WIDTH/IPAD_SCREEN_MAX_HEGHT, self.AssitantViewheight + topH):DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+25*(self.columnCount + 1) + self.columnCount* kButtonPoritatWidth* SCREE_WIDTH/IPHONE_SCREEN_MAX_WIDTH, self.AssitantViewheight  + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+36*(self.columnCount + 0.4) + (self.columnCount + 1) * kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT, self.AssitantViewheight + topH);
    }
    
    if ([IntergralModel sharModel].point_state) {
        self.center = [UIApplication sharedApplication].delegate.window.center;
    }

    self.integralView.frame = CGRectMake(0, 0, self.frame.size.width, 150);
    
//    self.backV.frame = CGRectMake(sender.frame.origin.x + sender.frame.size.width/2, 150, self.frame.size.width - (sender.frame.origin.x+ sender.frame.size.width/2) - 10, self.AssitantViewheight);
    
    self.backV.frame = CGRectMake(20, 150, self.frame.size.width - 40, self.AssitantViewheight + 10);
    self.backV.backgroundColor = VS_RGB(235, 235, 235);
    self.backV.layer.masksToBounds = YES;
    self.backV.layer.cornerRadius = 10;
    
    NSLog(@"%f",sender.frame.origin.x + sender.frame.size.width/2);
    NSLog(@"%f",self.frame.size.width);
    NSLog(@"%@",NSStringFromCGRect(self.backV.frame));
    
    
    [UIView animateWithDuration:.3f animations:^{

        //显示view
        if ([IntergralModel sharModel].point_state) {
            CGFloat wf = [UIApplication sharedApplication].delegate.window.frame.size.width * 0.9;
            
            self.frame = isPad?DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH):DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight  + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  wf, self.AssitantViewheight + topH);
            
//            CGRect fm = self.frame;
//            CGFloat fmw = [UIApplication sharedApplication].delegate.window.frame.size.width * 0.9;
//
//            if (self.featuresArray.count < 4) {
//                self.frame = CGRectMake(fm.origin.x, fm.origin.y, fmw, fm.size.height);
//            }
            
        }else{
            self.frame = isPad?DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+27*(self.columnCount + 1) + self.columnCount* kButtonPadPoritatWidth* SCREE_WIDTH/1024 + 10, self.AssitantViewheight + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+38*(self.featuresArray.count + 1) + self.featuresArray.count * kPadButtonWidth*SCREE_WIDTH/IPAD_SCREEN_MAX_HEGHT, self.AssitantViewheight + topH):DEVICEPORTRAIT?CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2, sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+25*(self.columnCount + 1) + self.columnCount* kButtonPoritatWidth* SCREE_WIDTH/IPHONE_SCREEN_MAX_WIDTH, self.AssitantViewheight  + topH):CGRectMake(sender.frame.origin.x+ sender.frame.size.width/2,sender.frame.origin.y+ (sender.frame.size.height - self.AssitantViewheight - topH)/2,  12+36*(self.columnCount + 0.4) + (self.columnCount + 1) * kButtonWidth*SCREE_WIDTH/IPHONE_SCREEN_MAX_HEGHT, self.AssitantViewheight + topH);
        }
        if ([IntergralModel sharModel].point_state) {
            self.center = [UIApplication sharedApplication].delegate.window.center;
        }
    }];
    
}

-(void)clickShare:(UIButton *)sender{
    
    self.resultBlock(YES,sender);
    
}

@end
