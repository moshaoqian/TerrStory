//
//  KBModel.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBModel : NSObject


@end

// 列表
@interface KBListModel : NSObject

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *link;

@end

//鬼故事分类
@interface KBCategoryModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;

@end

