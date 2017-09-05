//
//  ApiParams.h
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/4.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiParams : NSObject
@end

@interface PageParams : NSObject
@property (nonatomic,copy) NSString* page;
-(NSDictionary *)buildParams;
@end

@interface ListParams : PageParams
@property (nonatomic,copy) NSString* type;
-(NSDictionary *)buildParams;
@end

@interface DetailParams : PageParams
@property (nonatomic,copy) NSString* detailId;
-(NSDictionary *)buildParams;
@end
