//
//  TipView.m
//  小助手view
//
//  Created by admin on 8/23/22.
//

#import "TipView.h"
#import "Masonry.h"

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        UIColor *color = [UIColor blackColor];
        self.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.layer.cornerRadius = 8;
        self.tipLabel = [[UILabel alloc] init];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.numberOfLines = 0;
        self.tipLabel.textColor = [UIColor whiteColor];
        self.tipLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.tipLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
}

@end
