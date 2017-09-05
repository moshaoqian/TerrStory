//
//  MTViewController.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController ()

//loading
@property (nonatomic, strong) UIActivityIndicatorView *pageLoadingView;

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showPageLoading
{
    if(self.pageLoadingView == nil){
        self.pageLoadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.navigationController.view addSubview:self.pageLoadingView];
    }
    self.pageLoadingView.hidden = NO;
    [self.pageLoadingView startAnimating];
    
}
- (void)hidePageLoading
{
    if(self.pageLoadingView != nil){
        self.pageLoadingView.hidden = YES;
        [self.pageLoadingView stopAnimating];
    }
}
@end
