//
//  TopView.h
//  小助手view
//
//  Created by admin on 8/22/22.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopView : UIView<MZTimerLabelDelegate>
@property (nonatomic,strong) UIButton *tipBtn;
@property (nonatomic,strong) UILabel *interalLabel;
@property (nonatomic,strong) MZTimerLabel *timeLabel;
@end

NS_ASSUME_NONNULL_END
