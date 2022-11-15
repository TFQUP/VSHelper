//
//  VSAssistantView.h
//  VSDK
//
//  Created by admin on 7/2/21.
//

#import <UIKit/UIKit.h>
#import "IntegralView.h"
NS_ASSUME_NONNULL_BEGIN

@interface VSAssistantView : UIView
@property (nonatomic,strong) IntegralView *integralView;
-(void)showAssitantViewWithSender:(UIButton *)sender ResultBlock:(void(^)(BOOL result,UIButton *clickedBtn))result;
@end

NS_ASSUME_NONNULL_END

