//
//  MBProgressHUD+Add.m
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/3/11.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD(add)

+ (void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview
{
    [self showHudWithTime:time text:text inView:superview center:CGPointMake(superview.frame.size.width/2, superview.frame.size.height/2)];
}

+ (void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview center:(CGPoint)center
{
    UIView *view = [[UIView alloc] init];
    view.center = center;
    view.bounds = CGRectMake(0, 0, DEVICE_SIZE.width, 44);
    
    view.backgroundColor = [UIColor clearColor];
    [superview addSubview:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    } completionBlock:^{
        [view removeFromSuperview];
    }];
}

@end
