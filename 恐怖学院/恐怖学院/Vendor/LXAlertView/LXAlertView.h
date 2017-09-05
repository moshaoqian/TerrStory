//
//  LXAlertView.h
//  LXAlertViewDemo
//
//  Created by 刘鑫 on 16/4/15.
//  Copyright © 2016年 liuxin. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , LXAShowAnimationStyle) {
    LXASAnimationDefault    = 0,
    LXASAnimationLeftShake  ,
    LXASAnimationTopShake   ,
    LXASAnimationNO         ,
};

typedef void(^LXAlertClickIndexBlock)(NSInteger clickIndex);
typedef void(^LXAlertClickPwdBlock)(NSString* pwdText,NSInteger clickIndex);

@interface LXAlertView : UIView

@property (nonatomic,copy)LXAlertClickIndexBlock clickBlock;

@property (nonatomic,assign)LXAShowAnimationStyle animationStyle;

@property (nonatomic,copy)LXAlertClickPwdBlock pwdBlock;

@property (nonatomic,strong)UITextField* pwdTextField;

@property (nonatomic,copy)NSString* message;
/**
 *  初始化alert方法（根据内容自适应大小，目前只支持1个按钮或2个按钮）
 *
 *  @param title         标题
 *  @param message       内容（根据内容自适应大小）
 *  @param cancelTitle   取消按钮
 *  @param otherBtnTitle 其他按钮
 *  @param block         点击事件block
 *
 *  @return 返回alert对象
 */

//带背景图(imageScale:高/宽)
-(instancetype)initWithImage:(UIImage *)image imageScale:(CGFloat)imageScale message:(NSString *)message isFromPaper:(BOOL)isFromPaper showGuide:(BOOL)showGuide cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block;


//摇一摇弹窗
-(instancetype)initWithImage:(UIImage *)image imageScale:(CGFloat)imageScale message:(NSString *)message title1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 btnTitle:(NSString *)btnTitle clickIndexBlock:(LXAlertClickIndexBlock)block;

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message isFromPaper:(BOOL)isFromPaper cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block;

//长文字
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block and:(BOOL)isHasLongTittle and:(BOOL)isMessageCenter;

//作者原方法
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block;
//输入密码
-(instancetype)initWithPwdTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickPwdBlock:(LXAlertClickPwdBlock)pwdBlock;

/**
 *  showLXAlertView
 */
-(void)showLXAlertView;

-(void)dismissAlertView;
/**
 *  不隐藏，默认为NO。设置为YES时点击按钮alertView不会消失（适合在强制升级时使用）
 */
@property (nonatomic,assign)BOOL dontDissmiss;
@end



@interface UIImage (colorful)
//a image using a color
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
