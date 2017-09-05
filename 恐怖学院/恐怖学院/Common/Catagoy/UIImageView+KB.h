//
//  UIImageView+KB.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (KB)

- (void)kb_setImageWithURL:(NSURL *)url;
- (void)kb_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

@end
