//
//  TitleView.h
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JFMX = 0,
    JLCX,
    JFSC,
} JF;

@interface TitleView : UIView
@property (nonatomic,assign)JF JFSTATE;
@property (nonatomic,strong) UILabel *windowTitle;
@end

NS_ASSUME_NONNULL_END
