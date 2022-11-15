//
//  DetailCell.h
//  VVSDK
//
//  Created by admin on 8/24/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCell : UITableViewCell

+(instancetype)detailCellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) UILabel *productLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END
