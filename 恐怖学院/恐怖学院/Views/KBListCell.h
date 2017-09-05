//
//  KBListCell.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/5.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBModel.h"

@interface KBListCell : UITableViewCell

@property (nonatomic, strong) KBListModel *model;
@property (nonatomic, assign) BOOL isLastCellInSection;

+ (CGFloat)heightForCell;
+ (id)cell:(UITableView *)tableView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
