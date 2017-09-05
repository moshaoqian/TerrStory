//
//  KBCatagoryCell.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBCatagoryCell.h"

@interface KBCatagoryCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KBCatagoryCell

+ (NSString *)reuseIdentifier {
    return @"VideoCategoryCollectionViewCell";
}

+ (CGSize)sizeForCell {
    CGFloat width = DEVICE_SIZE.width / 2 - 1;
    return CGSizeMake(width, width);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        if (animated) {
            [UIView animateWithDuration:.2 animations:^{
                _titleLabel.alpha = 0;
            }];
        } else {
            _titleLabel.alpha = 0;
        }
    } else {
        if (animated) {
            [UIView animateWithDuration:.2 animations:^{
                _titleLabel.alpha = 1;
            }];
        } else {
            _titleLabel.alpha = 1;
        }
    }
}

- (void)setupUI {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.backgroundColor = [UIColor colorWithRGB:0xfafafa];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(void)setCategoryModel:(KBCategoryModel *)categoryModel {
    
    _categoryModel = categoryModel;
    self.coverImageView.image = [UIImage imageNamed:self.categoryModel.img];
    self.titleLabel.text = [NSString stringWithFormat:@"#%@", self.categoryModel.title];
    
}
@end
