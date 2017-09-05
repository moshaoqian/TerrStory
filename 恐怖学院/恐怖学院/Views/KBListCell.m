//
//  KBListCell.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/5.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBListCell.h"

@interface KBListCell ()
{
    
}

@property (nonatomic, strong) UILabel *descView;
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIView *lineView;

@end
@implementation KBListCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    KBListCell *cell = (KBListCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[KBListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
        cell.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.3];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.35];
    }
    return cell;
}
+ (CGFloat)heightForCell {
    return 120* autoLayoutY;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFont(12* autoLayoutY);
        _titleView.textColor = kGrayColor;
        _titleView.textAlignment = NSTextAlignmentRight;
        [self  addSubview:_titleView];
        
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        _descView = [[UILabel alloc] init];
        _descView.font = kFont(16* autoLayoutY);
        _descView.textColor = kTitleColor;
        _descView.numberOfLines = 3;
        [self addSubview:_descView];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
        [self addSubview:_lineView];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WS(weakSelf);
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTrailingMargin);
        make.top.mas_equalTo(kTopMargin);
        make.bottom.mas_equalTo(-kBottomMargin);
        make.width.mas_equalTo(120* autoLayoutX);
    }];

    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kTrailingMargin);
        make.bottom.mas_equalTo(-kBottomMargin);
        make.height.mas_equalTo(20* autoLayoutY);
    }];

    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconView.mas_right).mas_offset(10);
        make.top.mas_equalTo(weakSelf.iconView.mas_top).mas_offset(-3);
        make.right.mas_equalTo(-kTrailingMargin);
        make.bottom.mas_equalTo(weakSelf.titleView.mas_top).mas_offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}
-(void)setModel:(KBListModel *)model {
    
    _model = model;
    self.titleView.text = model.title;
    [self.iconView kb_setImageWithURL:[NSURL URLWithString:model.img]];
    self.descView.text = model.desc;
}
@end
