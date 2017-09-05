//
//  ShowApiClient.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ShowApiCompletionBlock)(id result);

@interface ShowApiClient : NSObject

+ (void)post:(NSString *)path params:(NSDictionary<NSString*,NSString*> *)params completion :(ShowApiCompletionBlock)completion;

@end
