
//
//  Common.h
//  liaomao
//
//  Created by Mr.wc on 16/8/1.
//  Copyright © 2016年 wc. All rights reserved.
//
#import "AppDelegate.h"

//ShowApi
#define SHOWAPI_APPID @"45200"
#define SHOWAPI_SECRET @"72fb92ff5141477ebe4608cfa02f0803"
#define SHOWAPI_LIST_URL @"http://route.showapi.com/955-1"
#define SHOWAPI_DETAIL_URL @"http://route.showapi.com/955-2"

#pragma mark -------- 设备 --------
//定义的全屏尺寸（包含状态栏）
#define DEVICE_BOUNDS [[UIScreen mainScreen] bounds]
#define DEVICE_SIZE [[UIScreen mainScreen] bounds].size
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark -------- AppDelegate --------

//AppDelegate
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define autoLayoutX ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutX
#define autoLayoutY ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutY

#pragma mark -------- 日志 --------
//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MTLog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define MTLog(...)
#endif

#pragma mark -------- 弱引用 --------
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#pragma mark -------- 颜色 --------
//获得RGB颜色
#define kColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kColorPoint(r, g, b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define kColorRGBSame(rgb) kColor(rgb, rgb, rgb)

//全局色
#define kGlobalColor kColor(0, 0, 0)
#define kGlobalHighlightColor kColor(0, 0, 0)
#define kSelectGobalColor kColor(0,0,0)
#define kGlobalColorAlpha kColorAlpha(28, 27, 40, 0.9)

//标准色
#define kRedColor kColor(255, 0, 0)
#define kWhiteColor kColor(255, 255, 255)

//字色
#define kTitleColor UIColorRGB(0x242427)//标题和名字
#define kTextColor UIColorRGB(0x494951)//正文
#define kSecondTitleColor UIColorRGB(0x8F9098)
#define kGrayColor UIColorRGB(0xB8B3B4)

//白色
#define kTitleWhiteColor UIColorRGB(0xF0F8FF)//标题和名字

#define kBackGroundColor kColor(0, 0, 0)
#define kLineColor kColor(229, 229, 229)
#define kTableGrayColor kColor(76, 79, 100)

#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:a])

#define checkStringNull(Str) (Str) == [NSNull null] || (Str) == nil ? @”” : [NSString stringWithFormat:@”%@”, (Str)]

#pragma mark -------- 字体 --------
//系统默认字体
#define kFont(n) [UIFont systemFontOfSize:n]
#define kFontBold(n) [UIFont boldSystemFontOfSize:n]
#define kHeaderTitleFont kFontBold(18 * autoLayoutY)

#pragma mark -------- 距离 --------
//状态栏
#define kStatusBarHeight 20
#define kHeaderViewHeight 44
//菜单栏
#define kMenuWidth DEVICE_SIZE.width*3/5
//全局间距
#define kLeadingMargin 15
#define kTrailingMargin 15
#define kTopMargin 10
#define kBottomMargin 10
#define kSectionInstence 44
//其他
#define kCustonButtonHeight 46*autoLayoutY
#define kCustonButtonWidth 160*autoLayoutX

#pragma mark -------- 性别 --------
//性别
typedef enum{
    kSexTypeMale = 0, //男
    kSexTypeFemale = 1, //女
    kSexTypeUnknown = 2 //未知
} SexType;

int iosMajorVersion();

NSString *Localized(NSString *s);
NSString *LocalizedByLanguage(NSString *s, NSString *language);

CGSize ScreenSize();

NSString *EncodeText(NSString *string, int key);

typedef void (^CCWebImageBlock)(UIImage *image, NSError *error);








