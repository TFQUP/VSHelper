//
//  VSAssistantHelper.h
//  VSDK
//
//  Created by admin on 7/2/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSSDKDefine.h"
#import "VSBadgeBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface VSAssistantHelper : UIView

-(void)vsdk_assistantToolShowInVc:(UIViewController *)vc;

@property(strong,nonatomic)VSBadgeBtn * assitantBtn;
@property(nonatomic,strong) UIView *backV;
-(void)assistantShow;
-(void)assitantHide;
-(void)assitantClick;


@end

NS_ASSUME_NONNULL_END
