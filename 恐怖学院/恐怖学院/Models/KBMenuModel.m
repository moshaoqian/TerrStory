//
//  KBMenuModel.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBMenuModel.h"

@implementation KBMenuModel

+ (instancetype)title:(NSString *)title action:(nullable SEL)action {
    KBMenuModel *model = [KBMenuModel new];
    model.title = [title copy];
    model.action = action;
    return model;
}
@end
