//
//  ApiParams.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "ApiParams.h"

@implementation ApiParams

@end

@implementation PageParams

- (NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.page forKey:@"page"];
    return params;
}

@end

@implementation ListParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.type forKey:@"type"];
    [params setObject:self.page forKey:@"page"];
    return params;
}
@end

@implementation DetailParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.detailId forKey:@"id"];
    [params setObject:self.page forKey:@"page"];
    return params;
}

@end
