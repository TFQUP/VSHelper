//
//  VSTipsView.h
//  VSDK
//
//  Created by admin on 7/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^tipsBlock)(BOOL hide);
@interface VSTipsView : UIView

@property(nonatomic,strong)UIView * socialBgView;
@property(nonatomic,copy)tipsBlock block;

-(void)showTipsViewWithBlock:(tipsBlock)block;
@end

NS_ASSUME_NONNULL_END

