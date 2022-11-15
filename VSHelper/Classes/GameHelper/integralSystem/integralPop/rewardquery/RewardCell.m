//
//  RewardCell.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "RewardCell.h"
#import "Masonry.h"
#import "VSSDKDefine.h"
#import "VSDeviceHelper.h"
@implementation RewardCell

+ (instancetype)rewardCellWithTableview:(UITableView *)tableview{
    NSString *cellid = @"cell";
    RewardCell *cell= [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[RewardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.mainView = [[UIView alloc] init];
    self.rewardNameLabel = [[UILabel alloc] init];
    self.IntegralLabel = [[UILabel alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    
    self.giftCodeLabel = [[UILabel alloc] init];
    self.cpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.imagV = [[UIImageView alloc] init];
    self.imagV.image = [UIImage imageNamed:kSrcName(@"vsdk_integral_processing")];
    
    [self.contentView addSubview:self.mainView];
    [self.contentView addSubview:self.imagV];
    [self.mainView addSubview:self.rewardNameLabel];
    [self.mainView addSubview:self.IntegralLabel];
    [self.mainView addSubview:self.detailLabel];
    [self.mainView addSubview:self.timeLabel];
    [self.mainView addSubview:self.giftCodeLabel];
    [self.mainView addSubview:self.cpBtn];
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 3;
    self.mainView.backgroundColor = VS_RGB(235, 235, 235);
    
    self.rewardNameLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.IntegralLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textAlignment = NSTextAlignmentLeft;

    if(DEVICEPORTRAIT){
        self.rewardNameLabel.font = [UIFont systemFontOfSize:12];
        self.IntegralLabel.font = [UIFont systemFontOfSize:11];
        self.detailLabel.font = [UIFont systemFontOfSize:9];
        self.timeLabel.font = [UIFont systemFontOfSize:9];
        self.giftCodeLabel.font = [UIFont systemFontOfSize:9];
        self.cpBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    }else{
        self.rewardNameLabel.font = [UIFont systemFontOfSize:14];
        self.IntegralLabel.font = [UIFont systemFontOfSize:13];
        self.detailLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.giftCodeLabel.font = [UIFont systemFontOfSize:11];
        self.cpBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    
    
//    [self.cpBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.cpBtn setTitle:VSLocalString(@"Copy") forState:UIControlStateNormal];
    [self.cpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 下划线
     NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"复制" attributes:attribtDic];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:VSLocalString(@"Copy") attributes:attribtDic];
     //赋值
     self.cpBtn.titleLabel.attributedText = attribtStr;
    [self.cpBtn addTarget:self action:@selector(CPClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(self.contentView);
//        make.center.equalTo(self.contentView);
        
        if(DEVICEPORTRAIT){
            
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }else{
            
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }
        
    }];
    
    [self.rewardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top).offset(10);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rewardNameLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self.imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.mainView.mas_right).offset(-10);
    }];
    
    if(DEVICEPORTRAIT){
        [self.IntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rewardNameLabel);
            make.right.equalTo(self.imagV.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.detailLabel);
            make.right.equalTo(self.imagV.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
    }else{
        [self.IntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rewardNameLabel);
            make.right.equalTo(self.imagV.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.detailLabel);
            make.right.equalTo(self.imagV.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
    }
    
   
    
    [self.giftCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
//        make.width.equalTo(self.mainView);
        make.width.mas_equalTo(140);
        make.height.mas_offset(15);
    }];
    
    [self.cpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.giftCodeLabel);
        make.left.equalTo(self.giftCodeLabel.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    
}

-(void)CPClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.giftcode;
//    VS_SHOW_SUCCESS_STATUS(@"已复制到粘贴板");
    VS_SHOW_SUCCESS_STATUS(VSLocalString(@"Copy successfully,Please go to the game to redeem"));
}


-(void)setRmodel:(RewardModel *)rmodel{
    
    self.rewardNameLabel.text = rmodel.gift_name;
    self.detailLabel.text = rmodel.gift_content;
    self.IntegralLabel.text = [NSString stringWithFormat:@"%@ :%@",VSLocalString(@"Pts"),rmodel.point];
    if (rmodel.status == 1) {
        self.imagV.image = [UIImage imageNamed:kSrcName(@"vsdk_integral_processing")];
    }else if (rmodel.status == 2){
        self.imagV.image = [UIImage imageNamed:kSrcName(@"vsdk_integral_redeemed")];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Time"),[self timeWithYearMonthDayCountDown:rmodel.time]];
    
    self.giftCodeLabel.text = [NSString stringWithFormat:@"%@: %@",VSLocalString(@"Gift Code"),rmodel.gift_code];
    self.giftcode = rmodel.gift_code;
    
    if ([VSTool isBlankString:self.giftcode]) {
        self.giftCodeLabel.hidden = YES;
        self.cpBtn.hidden = YES;
    }
    
    CGFloat timew = [VSDeviceHelper sizeWithFontStr:self.timeLabel.text WithFontSize:8] + 10;
    CGFloat giftw = [VSDeviceHelper sizeWithFontStr:self.giftCodeLabel.text WithFontSize:8] + 20;
    CGFloat copyw = [VSDeviceHelper sizeWithFontStr:self.cpBtn.titleLabel.text WithFontSize:8] + 20;
    
    
    [self.IntegralLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rewardNameLabel);
        make.right.equalTo(self.imagV.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(timew, 15));
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detailLabel);
        make.right.equalTo(self.imagV.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(timew, 15));
    }];
    
    
    [self.giftCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
//        make.width.equalTo(self.mainView);
//        make.width.mas_equalTo(140);
        make.width.mas_equalTo(giftw);
        make.height.mas_offset(15);
    }];
    
    [self.cpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.giftCodeLabel);
        make.left.equalTo(self.giftCodeLabel.mas_right).offset(0);
//        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.size.mas_equalTo(CGSizeMake(copyw, 15));
    }];
}

- (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp{
    // 时间戳转日期
    
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setDateFormat:@"dd"];
//    [dateFormatter setDateFormat:type];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
//    NSInteger day = [dateStr integerValue];
    return dateStr;
}
@end
