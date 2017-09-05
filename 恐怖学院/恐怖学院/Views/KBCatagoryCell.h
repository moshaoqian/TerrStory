//
//  KBCatagoryCell.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBModel.h"

@interface KBCatagoryCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
+ (CGSize)sizeForCell;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@property (nonatomic, strong) KBCategoryModel *categoryModel;

@end
