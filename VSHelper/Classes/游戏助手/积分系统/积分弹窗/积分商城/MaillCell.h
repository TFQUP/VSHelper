//
//  MaillCell.h
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import "MallModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MaillCell : UITableViewCell<MZTimerLabelDelegate>
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UILabel *rewardNameLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UIButton *exchangeBtn;

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *endtimeLabel;
@property (nonatomic,strong) UILabel *remainLabel;

@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) MZTimerLabel *timeLabel;

+(instancetype)mallCellWithTableview:(UITableView *)tableview;

@property (nonatomic,copy) NSAttributedString *attributeStr;
@property (nonatomic,strong) MallModel *MModel;
@end

NS_ASSUME_NONNULL_END
