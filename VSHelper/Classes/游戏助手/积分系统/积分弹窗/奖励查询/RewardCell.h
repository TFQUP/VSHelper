//
//  RewardCell.h
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import <UIKit/UIKit.h>
#import "RewardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RewardCell : UITableViewCell
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UILabel *rewardNameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *IntegralLabel;
@property (nonatomic,strong) UILabel *timeLabel;


@property (nonatomic,strong) UILabel *giftCodeLabel;
@property (nonatomic,strong) UIButton *cpBtn;

@property (nonatomic,strong) UIImageView *imagV;

@property (nonatomic,copy) NSString *giftcode;

@property (nonatomic,strong) RewardModel *rmodel;

+(instancetype)rewardCellWithTableview:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
