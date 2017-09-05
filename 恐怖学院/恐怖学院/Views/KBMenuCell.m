//
//  KBMenuCell.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBMenuCell.h"

#import "KBMenuModel.h"

@interface KBMenuCell ()
{
    
}

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIImageView* arrowView;

@end

@implementation KBMenuCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    KBMenuCell *cell = (KBMenuCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[KBMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
        cell.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.3];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.35];
    }
    return cell;
}
+ (CGFloat)heightForCell {
    return 50* autoLayoutY;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFont(18* autoLayoutY);
        _titleView.textColor = kTitleWhiteColor;
        [self  addSubview:_titleView];
        
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage imageNamed:@"t_right"];
        [self addSubview:_arrowView];
        
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
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.right.mas_equalTo(100* autoLayoutX);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kTrailingMargin);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}
-(void)setModel:(KBMenuModel *)model {
    
    _model = model;
    self.titleView.text = model.title;
}

@end
