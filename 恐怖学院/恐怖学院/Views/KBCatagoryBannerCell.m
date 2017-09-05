//
//  KBCatagoryBannerCell.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBCatagoryBannerCell.h"
#import "ZYBannerView.h"
#import "KBModel.h"

static NSString* bannerTitleFontName = @"STHeitiSC-Light";

@interface KBCatagoryBannerCell () <ZYBannerViewDelegate, ZYBannerViewDataSource>

@property (nonatomic, strong) ZYBannerView *bannerView;

@end

@implementation KBCatagoryBannerCell

+ (NSString *)reuseIdentifier {
    return @"KBCatagoryBannerCell";
}

+ (CGSize)sizeForCell {
    return CGSizeMake(DEVICE_SIZE.width, 214);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.bannerView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - ZYBannerViewDelegate & ZYBannerViewDataSource

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.recommandArray.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    KBListModel *model = self.recommandArray[index];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView kb_setImageWithURL:[NSURL URLWithString:model.img]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [imageView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(imageView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:bannerTitleFontName size:38* autoLayoutY];
    titleLabel.textColor = kTitleWhiteColor;
    titleLabel.text = model.title;
    [imageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.centerY.equalTo(imageView.mas_centerY);
    }];
    
    return imageView;
}

- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    if ([self.bannerDelegate respondsToSelector:@selector(catagoryBannerCell:didSelectItemAtIndex:)]) {
        [self.bannerDelegate catagoryBannerCell:self didSelectItemAtIndex:index];
    }
}

#pragma mark -

- (ZYBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[ZYBannerView alloc] init];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.autoScroll = true;
        _bannerView.scrollInterval = 8.f;
        _bannerView.shouldLoop = YES;
        _bannerView.pageControl.hidden = YES;
    }
    return _bannerView;
}
-(void)setRecommandArray:(NSArray *)recommandArray {
    
    _recommandArray = recommandArray;
    [self.bannerView reloadData];
}
@end
