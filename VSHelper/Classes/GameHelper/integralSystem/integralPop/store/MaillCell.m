//
//  Maillself.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "MaillCell.h"
#import "Masonry.h"
#import "VSSDKDefine.h"
#import "VSDeviceHelper.h"
@implementation MaillCell

+ (instancetype)mallCellWithTableview:(UITableView *)tableview{
    static NSString *cellid = @"cell";
    MaillCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[MaillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    MaillCell *cell = [[MaillCell alloc] init];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.contentLabel = [[UILabel alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.endtimeLabel = [[UILabel alloc] init];
    self.remainLabel = [[UILabel alloc] init];
    self.tipLabel = [[UILabel alloc] init];
    self.exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.timeLabel = [[MZTimerLabel alloc]initWithTimerType:MZTimerLabelTypeTimer];
    
//    self.timeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.mainView];
    [self.mainView addSubview:self.rewardNameLabel];
    [self.mainView addSubview:self.contentLabel];
    [self.mainView addSubview:self.detailLabel];
    [self.mainView addSubview:self.endtimeLabel];
    [self.mainView addSubview:self.remainLabel];
    [self.mainView addSubview:self.tipLabel];
    [self.mainView addSubview:self.exchangeBtn];
    [self.mainView addSubview:self.timeLabel];
//    self.timeLabel.delegate = self;
//    [self.timeLabel start];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 3;
    self.mainView.backgroundColor = VS_RGB(235, 235, 235);
    
    self.rewardNameLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.endtimeLabel.textAlignment = NSTextAlignmentLeft;
    
    if(DEVICEPORTRAIT){
        self.rewardNameLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.font = [UIFont systemFontOfSize:8];
        self.contentLabel.font = [UIFont systemFontOfSize:8];
        self.endtimeLabel.font = [UIFont systemFontOfSize:8];
        self.remainLabel.font = [UIFont systemFontOfSize:8];
        self.tipLabel.font = [UIFont systemFontOfSize:8];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:8];
    }else{
        self.rewardNameLabel.font = [UIFont systemFontOfSize:14];
        self.detailLabel.font = [UIFont systemFontOfSize:11];
        self.contentLabel.font = [UIFont systemFontOfSize:11];
        self.endtimeLabel.font = [UIFont systemFontOfSize:11];
        self.remainLabel.font = [UIFont systemFontOfSize:11];
        self.tipLabel.font = [UIFont systemFontOfSize:11];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:11];
    }
    
    
    
    self.detailLabel.numberOfLines = 0;
    
    
//    self.rewardNameLabel.backgroundColor = [UIColor redColor];
//    self.detailLabel.backgroundColor = [UIColor blueColor];
    
//    [self.exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [self.exchangeBtn setTitle:VSLocalString(@"Redeem") forState:UIControlStateNormal];
    self.exchangeBtn.backgroundColor = VS_RGB(255, 157, 0);
    self.exchangeBtn.layer.masksToBounds = YES;
    self.exchangeBtn.layer.cornerRadius = 8;
    [self.exchangeBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.exchangeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.exchangeBtn addTarget:self action:@selector(redeemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
    
    if(DEVICEPORTRAIT){
        [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mainView.mas_right).offset(-20);
            make.centerY.equalTo(self.mainView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(70, 30));
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.exchangeBtn.mas_bottom).offset(5);
            make.centerX.equalTo(self.exchangeBtn);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
    }else{
        [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mainView.mas_right).offset(-20);
            make.centerY.equalTo(self.mainView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(70, 30));
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.exchangeBtn.mas_bottom).offset(5);
            make.centerX.equalTo(self.exchangeBtn);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
    }
    
    

//    self.tipLabel.backgroundColor = [UIColor redColor];
    
    [self.rewardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top).offset(5);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rewardNameLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.right.equalTo(self.exchangeBtn.mas_left).offset(20);
        make.height.mas_equalTo(12);
    }];
    
    [self.endtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.right.equalTo(self.exchangeBtn.mas_left).offset(20);
        make.height.mas_equalTo(12);
    }];
    
    [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endtimeLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
        make.right.equalTo(self.exchangeBtn.mas_left).offset(20);
        make.height.mas_equalTo(12);
    }];
    
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
//        make.left.equalTo(self.mainView.mas_right).offset(10);
//        make.right.equalTo(self.mainView.mas_left).offset(-10);
//        make.height.mas_equalTo(45);
//    }];
//    self.detailLabel.backgroundColor = [UIColor redColor];
//    CGFloat strw = [VSDeviceHelper sizeWithFontStr:self.detailLabel.text WithFontSize:12];
//
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
//        make.left.equalTo(self.mainView.mas_left).offset(10);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
////        make.width.mas_equalTo(strw);
//    }];
//
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
//        make.left.equalTo(self.detailLabel.mas_right).offset(0);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
//    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
////        make.left.equalTo(self.detailLabel.mas_right).offset(0);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(200);
//    }];
    CGFloat strw = 0;
    if(DEVICEPORTRAIT){
        strw = [VSDeviceHelper sizeWithFontStr:self.detailLabel.text WithFontSize:8];
    }else{
        strw = [VSDeviceHelper sizeWithFontStr:self.detailLabel.text WithFontSize:11];
    }
    

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(strw);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
        make.left.equalTo(self.detailLabel.mas_right).offset(0);
        make.right.equalTo(self.mainView.mas_right).offset(-10);
        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(200);
    }];
}

-(void)redeemClick{
    
}

//- (void)setAttributeStr:(NSAttributedString *)attributeStr{
//    CGFloat strw = [VSDeviceHelper sizeWithFontStr:self.detailLabel.text WithFontSize:12];
//
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
//        make.left.equalTo(self.mainView.mas_left).offset(10);
////        make.right.equalTo(self.mainView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(strw);
//    }];
//    [self.mainView layoutIfNeeded];
//    [self.detailLabel layoutIfNeeded];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
//        make.left.equalTo(self.detailLabel.mas_right).offset(0);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
////        make.width.mas_equalTo(200);
//    }];
//}


- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    if([timerLabel isEqual:self.timeLabel]){
//        int second = (int)time %60;//秒
//        int minute = ((int)time / 60) % 60;
//        int hours = time / 3600;
//        int day = (int)time / (24 * 3600);
        
        int days = (int)(time/(3600*24));
        int hours = (int)((time-days*24*3600)/3600);
        int minute = (int)(time-days*24*3600-hours*3600)/60;
        int second = time-days*24*3600-hours*3600-minute*60;
        
//        if (hours == 0 && minute == 0){
//            return [NSString stringWithFormat:@"%02ds)",second];
//        }else if (hours == 0){
//            return [NSString stringWithFormat:@"%02dm %02ds)",minute,second];
//        }else{
//            return [NSString stringWithFormat:@"%02dD%02dh%02dm)",day,hours,minute];
////            return [NSString stringWithFormat:@"%02dD%02dh%02dm%02ds)",day,hours,minute,second];
//        }
//        return [NSString stringWithFormat:@"%02dD:%02dh:%02dm)",days,hours,minute];
        return [NSString stringWithFormat:@"%02dd:%02dh:%02dm)",days,hours,minute];
    }
    else
    return nil;
}

-(void)setMModel:(MallModel *)MModel{
    NSMutableAttributedString * attriStr1 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString * attriStr2 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString * attriStr3 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString * attriStrend = [[NSMutableAttributedString alloc] initWithString:@")"];
    
    //限时免费兑换字符串
    NSMutableAttributedString * discountStr = [[NSMutableAttributedString alloc] init];
//    self.attriStr4 = [[NSMutableAttributedString alloc] init];

//    attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(兑换积分:"]];
//    attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:VSLocalString(@"(Pts: ")]];
    attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@: ",@"(",VSLocalString(@"Pts")]];
    BOOL discountValid = MModel.discount_start_time <= MModel.cur_time && MModel.cur_time <= MModel.discount_end_time;
    if ([MModel.real_point integerValue] == 0 && discountValid) {
        
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:@"(限时免费兑换"];
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:VSLocalString(@"(Limited Time Free")];
        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@",VSLocalString(@"Limited Time Free")]];
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        // 表情图片
        attchImage.image = [UIImage imageNamed:kSrcName(@"clock")];
        // 设置图片大小
        
        if(DEVICEPORTRAIT){
            attchImage.bounds = CGRectMake(2, -2, 8, 8);
        }else{
            attchImage.bounds = CGRectMake(2, -2, 11, 11);
        }
        
        
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        [attriStr1 insertAttributedString:stringImage atIndex:attriStr1.length];
        //动态倒计时
        NSInteger cutTime = MModel.discount_end_time - MModel.cur_time;
//        NSInteger cutTime = MModel.cur_time - MModel.discount_start_time;
        [self.timeLabel setCountDownTime:cutTime];
        self.timeLabel.delegate = self;
        [self.timeLabel start];
        self.timeLabel.hidden = NO;
        
//        attriStr2 = [[NSMutableAttributedString alloc]initWithString:MModel.gift_point attributes:nil];//(兑换积分：10
//        [attriStr1 appendAttributedString:attriStr2];
    }else if(0 < [MModel.real_point integerValue] && [MModel.real_point integerValue] < [MModel.gift_point integerValue] && discountValid){
        
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(兑换积分:"]];
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:VSLocalString(@"(Pts: ")]];
        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@: ",@"(",VSLocalString(@"Pts")]];
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        attriStr2 = [[NSMutableAttributedString alloc]initWithString:MModel.gift_point attributes:attribtDic];//(兑换积分：10
        [attriStr1 appendAttributedString:attriStr2];//添加下划线
//        attriStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"限时优惠:%@",MModel.real_point]];
//        attriStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:VSLocalString(@"Discounted:%@"),MModel.real_point]];
        attriStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",VSLocalString(@"Discounted"),MModel.real_point]];
        //动态倒计时
        NSInteger cutTime = MModel.discount_end_time- MModel.cur_time;
//        NSInteger cutTime = MModel.cur_time - MModel.discount_start_time;
        [self.timeLabel setCountDownTime:cutTime];
        self.timeLabel.delegate = self;
        [self.timeLabel start];
        self.timeLabel.hidden = NO;
        /**
         添加图片到指定的位置
         */
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        // 表情图片
        attchImage.image = [UIImage imageNamed:kSrcName(@"clock")];
        // 设置图片大小
        if(DEVICEPORTRAIT){
            attchImage.bounds = CGRectMake(2, -2, 8, 8);
        }else{
            attchImage.bounds = CGRectMake(2, -2, 11, 11);
        }
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        [attriStr3 insertAttributedString:stringImage atIndex:attriStr3.length];
        [attriStr1 appendAttributedString:attriStr3];
    }else{
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(兑换积分:"]];
//        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:VSLocalString(@"(Pts: ")]];
        attriStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@: ",@"(",VSLocalString(@"Pts")]];
        attriStr2 = [[NSMutableAttributedString alloc]initWithString:MModel.gift_point attributes:nil];//(兑换积分：10
        [attriStr1 appendAttributedString:attriStr2];
        [attriStr1 appendAttributedString:attriStrend];
    }
    
    
    self.rewardNameLabel.text = MModel.gift_name;
    self.contentLabel.text = MModel.gift_content;
//    self.remainLabel.text = [NSString stringWithFormat:@"礼包剩余数量:%@",MModel.remain_number];
    self.remainLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Stock"),MModel.remain_number];
    self.detailLabel.attributedText= attriStr1;
    
//    NSString *lastTime = [NSString stringWithFormat:@"%ld",discount_end_time - cur_time];
    
//    self.endtimeLabel.text = [NSString stringWithFormat:@"礼包兑换截止时间:%@",[self timeWithYearMonthDayCountDown:MModel.gift_use_time]];
    self.endtimeLabel.text = [NSString stringWithFormat:@"%@:%@",VSLocalString(@"Redemption Deadline"),[self timeWithYearMonthDayCountDown:MModel.gift_use_time]];
    
    if (MModel.is_exchange == 1) {
//        [self.exchangeBtn setTitle:@"已兑换" forState:UIControlStateNormal];
        [self.exchangeBtn setTitle:VSLocalString(@"Redeemed") forState:UIControlStateNormal];
        self.exchangeBtn.userInteractionEnabled = NO;
    }
    
//    self.exchangeBtn.CodeTags = gift_id;
//    NSString *sendtype = [NSString stringWithFormat:@"%ld",goods_send_type];
//    self.exchangeBtn.ChangeType = sendtype;
//    [self.exchangeBtn addTarget:self action:@selector(redmeeClick:) forControlEvents:UIControlEventTouchUpInside];

//    self.tipLabel.text = @"仅限兑换一次";
    self.tipLabel.text = VSLocalString(@"Redeem only once");
    if (MModel.times == 1 || MModel.times == 2) {
        self.tipLabel.hidden = NO;
    }else{
        self.tipLabel.hidden = YES;
    }
    
    
    [self layoutIfNeeded];
    NSString * str = self.detailLabel.text;
    CGFloat strw = 0;
    if(DEVICEPORTRAIT){
        strw = [VSDeviceHelper sizeWithFontStr:str WithFontSize:8];
    }else{
        strw = [VSDeviceHelper sizeWithFontStr:str WithFontSize:11];
    }

    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mainView.mas_left).offset(10);
//        make.right.equalTo(self.mainView.mas_right).offset(-10);
        make.height.mas_equalTo(12);
        
        if(DEVICEPORTRAIT){
            make.width.mas_equalTo(strw + 8);
        }else{
            make.width.mas_equalTo(strw + 10);
        }
        
        
    }];
    [self.mainView layoutIfNeeded];
    [self.detailLabel layoutIfNeeded];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLabel.mas_bottom).offset(0);
        make.left.equalTo(self.detailLabel.mas_right).offset(0);
        make.right.equalTo(self.mainView.mas_right).offset(-10);
        make.height.mas_equalTo(12);
//        make.width.mas_equalTo(200);
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
