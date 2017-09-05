//
//  UserDefault.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "UserDefault.h"

@implementation UserDefault

+ (NSString *)getString: (NSString *)key
{
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if(value == nil) return @"";
    return value;
}

+ (void)setString: (NSString *)key value:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (int)getInt: (NSString *)key
{
    int value = (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
    return value;
}

+ (void)setInt: (NSString *)key value:(int)value
{
    [[NSUserDefaults standardUserDefaults]setObject:@(value) forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)getBool: (NSString *)key
{
    BOOL value = [[[NSUserDefaults standardUserDefaults]objectForKey:key] boolValue];
    return value;
}

+ (void)setBool: (NSString *)key value:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults]setObject:@(value) forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+ (NSDictionary *)getDictionary: (NSString *)key
{
    NSDictionary *value = [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
    return value;
}

+ (void)setDictionary: (NSString *)key value:(NSDictionary *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
