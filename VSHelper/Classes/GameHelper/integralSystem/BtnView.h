//
//  BtnView.h
//  小助手view
//
//  Created by admin on 8/22/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BtnView : UIView
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *iconLabel;
@property (nonatomic,strong) UIButton *clickBtn;
@property (nonatomic,strong) UILabel *imgLabel;
@property (nonatomic,copy) void(^clickBlock)(NSInteger tag);

-(void)showTipWithMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
