//
//  KBMenuCell.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "MTTableCell.h"

@class KBMenuModel;

@interface KBMenuCell : MTTableCell

@property (nonatomic, strong) KBMenuModel *model;
@property (nonatomic, assign) BOOL isLastCellInSection;

+ (CGFloat)heightForCell;
+ (id)cell:(UITableView *)tableView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
