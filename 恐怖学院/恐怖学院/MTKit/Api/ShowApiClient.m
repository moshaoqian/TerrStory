//
//  ShowApiClient.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "ShowApiClient.h"

@implementation ShowApiClient

+ (void)post:(NSString *)path params:(NSDictionary<NSString*,NSString*> *)params completion :(ShowApiCompletionBlock)completion {
    
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:SHOWAPI_APPID andSign:SHOWAPI_SECRET];
    [request post:path
          timeout:20000//超时设置为20秒
           params:params
   withCompletion:^(NSDictionary<NSString *,id> *result) {
//       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
//       NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
       completion(result);
   }];
}
@end
