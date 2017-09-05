//
//  AppDelegate.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "AppDelegate.h"
#import "KBMenuController.h"
#import "KBCatagoryController.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置屏幕适配属性
    [self setAutoLayOutProperty];
    //配置RootVC
    [self setRootVC];
    
    return YES;
}
- (void)setRootVC {
    
    KBMenuController *menuVC = [[KBMenuController alloc] init];
    UINavigationController *catagoryNav = [[UINavigationController alloc] initWithRootViewController:[[KBCatagoryController alloc] init]];
    catagoryNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    catagoryNav.navigationBar.tintColor = kTitleWhiteColor;
    catagoryNav.navigationBar.barTintColor = kGlobalColor;
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:catagoryNav leftDrawerViewController:menuVC];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumLeftDrawerWidth:kMenuWidth];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setShouldStretchDrawer:NO];
    [self.drawerController setAnimationVelocity:1500];
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];//侧滑效果
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.drawerController];
}
- (void)setAutoLayOutProperty
{
    if (DEVICE_SIZE.width<DEVICE_SIZE.height) {
        if(DEVICE_SIZE.height > 667){
            self.autoLayOutX = DEVICE_SIZE.width/375;
            self.autoLayOutY = DEVICE_SIZE.height/667;
        }else{
            self.autoLayOutX = 1.0;
            self.autoLayOutY = 1.0;
        }
    }else{
        if(DEVICE_SIZE.width > 375){
            self.autoLayOutX = DEVICE_SIZE.height/375;
            self.autoLayOutY = DEVICE_SIZE.width/667;
        }else{
            self.autoLayOutX = 1.0;
            self.autoLayOutY = 1.0;
        }
    }
}
@end
