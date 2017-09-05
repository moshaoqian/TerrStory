//
//  UIImageView+KB.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "UIImageView+KB.h"

@implementation UIImageView (KB)

- (void)kb_setImageWithURL:(NSURL *)url {
    typeof(self) __weak weakSelf = self;
    [self sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeMemory) {
            weakSelf.image = image;
        } else {
            if (image) {
                [UIView transitionWithView:weakSelf duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    weakSelf.image = image;
                } completion:nil];
            }
        }
    }];
}

- (void)kb_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    typeof(self) __weak weakSelf = self;
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeMemory) {
            weakSelf.image = image;
        } else {
            if (image) {
                [UIView transitionWithView:weakSelf duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    weakSelf.image = image;
                } completion:nil];
            }
        }
    }];
}
@end
