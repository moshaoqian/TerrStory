//
//  KBMenuFooterView.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBMenuFooterView.h"

@interface KBMenuFooterView()

@property (nonatomic, strong) UILabel* verLeftView;
@property (nonatomic, strong) UILabel* verRightView;
//版本号
@property (nonatomic, strong) UILabel* vresonView;
@property (nonatomic, strong) NSMutableArray* verRightArray;
@property (nonatomic, strong) NSMutableArray* verLeftArray;
@end

@implementation KBMenuFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setdata];
        [self addSubViews];
    }
    return self;
}
- (void)setdata {
    
    [self.verRightArray addObject:@[[@"车开得飞快，" VerticalString]]];
    [self.verLeftArray addObject:@[[@"一个老太婆趴在窗外看著我。" VerticalString]]];

}
- (void)addSubViews {
    

    self.verLeftView = [[UILabel alloc] init];
    self.verLeftView.text = [@"一个老太婆趴在窗外看著我。"VerticalString];
//    self.verLeftView.text = [self.verLeftArray objectAtIndex:0];
    self.verLeftView.numberOfLines = 0;
    self.verLeftView.textColor = kTitleWhiteColor;
    self.verLeftView.font = kFont(16* autoLayoutY);
    [self.verLeftView sizeToFit];
    [self addSubview:self.verLeftView];
    
    self.verRightView = [[UILabel alloc] init];
    self.verRightView.text = [@"车开得飞快，"VerticalString];
//    self.verRightView.text = [self.verRightArray objectAtIndex:0];
    self.verRightView.numberOfLines = 0;
    self.verRightView.textColor = kTitleWhiteColor;
    self.verRightView.font = kFont(16* autoLayoutY);
    [self.verRightView sizeToFit];
    [self addSubview:self.verRightView];
    
    self.vresonView = [[UILabel alloc] init];
    self.vresonView.numberOfLines = 0;
    self.vresonView.text = [NSString stringWithFormat:@"Verson: 1.0.2"];
    self.vresonView.textColor = kTitleWhiteColor;
    self.vresonView.font = kFont(12* autoLayoutY);
    [self.vresonView sizeToFit];
    [self addSubview:self.vresonView];
    
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    WS(weakSelf);
    
    [self.verLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX).mas_offset(-11);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];

    [self.verRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX).mas_offset(11);
        make.top.mas_equalTo(weakSelf.verLeftView.mas_top);
    }];
    
    [self.vresonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(-kBottomMargin);
    }];

}
#pragma mark - setter
-(NSMutableArray *)verLeftArray {
    
    if (!_verLeftArray) {
        _verLeftArray = [NSMutableArray array];
    }
    return _verLeftArray;
}
-(NSMutableArray *)verRightArray {
    
    if (!_verRightArray) {
        _verRightArray = [NSMutableArray array];
    }
    return _verRightArray;
}

@end
