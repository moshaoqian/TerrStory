//
//  KBModel.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBModel.h"

@implementation KBListModel

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.objectId = value;
    }
}
@end

@implementation KBCategoryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"type":@"type",
             @"img": @"img",
             @"title": @"title"
             };
}
@end
