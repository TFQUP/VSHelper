//
//  DetailCell.m
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import "DetailCell.h"
#import "Masonry.h"
@implementation DetailCell

+ (instancetype)detailCellWithTableView:(UITableView *)tableView{
    NSString *cellid = @"cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
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
    self.priceLabel = [[UILabel alloc] init];
    self.productLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.productLabel];
    self.productLabel.font = [UIFont systemFontOfSize:15];
    self.priceLabel.font = [UIFont systemFontOfSize:17];
    self.productLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.productLabel.textColor = [UIColor blackColor];
    self.priceLabel.textColor = [UIColor blackColor];
    [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width * 0.6, self.contentView.frame.size.height));
        make.centerY.equalTo(self);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.left.equalTo(self.productLabel.mas_left);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}

@end
