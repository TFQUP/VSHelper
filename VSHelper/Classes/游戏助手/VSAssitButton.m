//
//  VSAssitButton.m
//  VSDK
//
//  Created by admin on 7/2/21.
//


#import "VSAssitButton.h"
#import "VSSDKDefine.h"
#import <objc/runtime.h>
NSString const *assistantBtnBadgeAlertImageViewKey = @"assistantBtnBadgeAlertImageViewKey";
NSString const *assistantBtnBadgeImageKey = @"assistantBtnBadgeImageKey";
NSString const *assistantBtnBadgeAlertOriginXKey = @"assistantBtnBadgeOriginXKey";
NSString const *assistantBtnBadgeAlertOriginYKey = @"assistantBtnBadgeOriginYKey";
NSString const *assistantBtnShowBadgeKey = @"assistantBtnshowBadgeKey";

@implementation VSAssitButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = DEVICEPORTRAIT?[UIFont systemFontOfSize:9.0f]:  [UIFont systemFontOfSize:11.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
//    CGRect retValue  = isPad?DEVICEPORTRAIT?CGRectMake(-10,self.frame.size.height-13,contentRect.size.width + 20,15):CGRectMake(-18,self.frame.size.height-15,contentRect.size.width+36,16):DEVICEPORTRAIT?CGRectMake(-12,self.frame.size.height-12,contentRect.size.width + 24,15):CGRectMake(-18,self.frame.size.width-3,contentRect.size.width+36,16);
//
//    return retValue;
    
    CGRect retValue  = isPad?DEVICEPORTRAIT?CGRectMake(-10,self.frame.size.height-13,contentRect.size.width + 20,15):CGRectMake(-18,self.frame.size.height-15,contentRect.size.width+36,16):DEVICEPORTRAIT?CGRectMake(-12,self.frame.size.height-5,contentRect.size.width + 24,15):CGRectMake(-18,self.frame.size.width-3,contentRect.size.width+36,16);

    return retValue;
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGRect retValue = isPad?DEVICEPORTRAIT?CGRectMake((contentRect.size.width -self.frame.size.width*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT)/2 ,3,self.frame.size.width*SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT,(self.frame.size.width-3) * SCREE_HEIGHT/IPAD_SCREEN_MAX_HEGHT): CGRectMake(0,0,self.frame.size.width,self.frame.size.width-3):DEVICEPORTRAIT?CGRectMake((contentRect.size.width -self.frame.size.width*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT)/2 ,0,self.frame.size.width*SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT,(self.frame.size.width-3) * SCREE_HEIGHT/IPHONE_SCREEN_MAX_HEGHT): CGRectMake(0,0,self.frame.size.width,self.frame.size.width-3);
    
    return retValue;
}


-(UIImageView *)badgeAlertImageView{
    
   return objc_getAssociatedObject(self, &assistantBtnBadgeAlertImageViewKey);
}

-(void)setBadgeAlertImageView:(UIImageView *)badgeAlertImageView{
    
      objc_setAssociatedObject(self, &assistantBtnBadgeAlertImageViewKey, badgeAlertImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)badgeInit{
    
    self.badgeOriginX   = self.frame.size.width - self.badgeAlertImageView.frame.size.width/2;
    self.badgeOriginY   = -4;
    self.showBadge = YES;
    self.clipsToBounds = NO;
    
}

-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &assistantBtnBadgeAlertOriginXKey);
    return number.floatValue;
}

-(void) setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &assistantBtnBadgeAlertOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
}


-(CGFloat)badgeOriginY{
    
    NSNumber *number = objc_getAssociatedObject(self, &assistantBtnBadgeAlertOriginYKey);
       return number.floatValue;
}


-(void)setBadgeOriginY:(CGFloat)badgeOriginY{
    
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
     objc_setAssociatedObject(self, &assistantBtnBadgeAlertOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)showBadge{
    
    NSNumber *number = objc_getAssociatedObject(self, &assistantBtnShowBadgeKey);
       return number.boolValue;
}

-(void)setShowBadge:(BOOL)showBadge{

    NSNumber *number = [NSNumber numberWithBool:showBadge];
    objc_setAssociatedObject(self, &assistantBtnShowBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSString *)badgeImage{
    
     return objc_getAssociatedObject(self, &assistantBtnBadgeImageKey);
}

-(void)setBadgeImage:(NSString *)badgeImage{
   
    objc_setAssociatedObject(self, &assistantBtnBadgeImageKey, badgeImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.badgeAlertImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-2 ,0, 12, 12)];
    self.badgeAlertImageView.image = [UIImage imageNamed:badgeImage];
    [VSDeviceHelper addAnimationInView:self.badgeAlertImageView Duration:0.3];
    [self badgeInit];
    [self addSubview:self.badgeAlertImageView];
    
}

- (void)removeBadge
{

    [UIView animateWithDuration:0.2 animations:^{
        self.badgeAlertImageView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badgeAlertImageView removeFromSuperview];
    }];
}

@end

