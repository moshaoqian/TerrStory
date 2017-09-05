//
//  MBProgressHUD+Add.h
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/3/11.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD(add)

+(void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview;
+(void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview center:(CGPoint)center;

@end
