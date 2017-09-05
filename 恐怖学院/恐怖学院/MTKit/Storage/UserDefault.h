//
//  UserDefault.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefault : NSObject

+ (NSString *)getString: (NSString *)key;
+ (void)setString: (NSString *)key value:(NSString *)value;

+ (int)getInt: (NSString *)key;
+ (void)setInt: (NSString *)key value:(int)value;

+ (BOOL)getBool: (NSString *)key;
+ (void)setBool: (NSString *)key value:(BOOL)value;


+ (NSDictionary *)getDictionary: (NSString *)key;
+ (void)setDictionary: (NSString *)key value:(NSDictionary *)value;

@end
