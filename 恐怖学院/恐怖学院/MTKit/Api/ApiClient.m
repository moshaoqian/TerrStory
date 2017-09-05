//
//  ApiClient.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "ApiClient.h"

static ApiClient *apiClient;

@implementation ApiClient

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        apiClient = [[ApiClient alloc] init];
    });
    return apiClient;
}
@end
