//
//  KBCatagoryReusableView.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBCatagoryReusableView.h"

@implementation KBCatagoryReusableView


+ (NSString *)reuseIdentifier {
    return @"KBCatagoryReusableView";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];

    [self addSubview:titleLabel];
    titleLabel.textColor = kTitleColor;
    titleLabel.font = kFont(16* autoLayoutY);
    titleLabel.text = @"分类";
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

@end
