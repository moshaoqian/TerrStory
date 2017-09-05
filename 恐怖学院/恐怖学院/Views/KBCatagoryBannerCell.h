//
//  KBCatagoryBannerCell.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBCatagoryBannerCell;

@protocol KBCatagoryBannerCellDelegate <NSObject>

- (void)catagoryBannerCell:(KBCatagoryBannerCell *)cell didSelectItemAtIndex:(NSInteger)index;

@end

@interface KBCatagoryBannerCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
+ (CGSize)sizeForCell;

@property (nonatomic, strong) NSArray *recommandArray;
@property (nonatomic, weak) id<KBCatagoryBannerCellDelegate> bannerDelegate;

@end
