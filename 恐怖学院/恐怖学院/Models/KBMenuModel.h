//
//  KBMenuModel.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBMenuModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) NSInteger identifer;

+ (instancetype)title:(NSString *)title action:(nullable SEL)action;

@end
