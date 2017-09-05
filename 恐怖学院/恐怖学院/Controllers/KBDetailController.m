//
//  KBDetailController.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBDetailController.h"
#import "KBModel.h"

@interface KBDetailController ()<UITextViewDelegate>

@property (nonatomic,strong) UIImageView *headView;

@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) NSMutableArray* detailArray;

@property (nonatomic,strong) UITextView* textView;

@end

@implementation KBDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGrayColor;
    [self updateData];

//    [self setUI];

//    [self setTableView];

    
//    [self setNavView:YES];
    
}
- (void)updateData {
    
    DetailParams* params = [DetailParams alloc];
    params.page = @"1";
    params.detailId = self.detailId;
    
    
    [ShowApiClient post:SHOWAPI_DETAIL_URL params:[params buildParams] completion:^(id result) {
        
        NSDictionary *dataDict = result[@"showapi_res_body"];
        NSString* text = [dataDict objectForKey:@"text"];
        text = [self filterText:text];

        MTLog(@"%@",text);
        [self setUI:text];
//        [self.tableView reloadData];
//        [self endRefreshing];
    }];
}
- (NSString*)filterText:(NSString*)text{
    
    text = [text stringByReplacingOccurrencesOfString:@"&nbsp;&nbsp;&nbsp;" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"neirong336();" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"c2();" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"c1();" withString:@""];
    return text;
}
- (void)setUI:(NSString*)text {
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = kTitleColor;
    self.textView.font = kFont(16* autoLayoutY);
    self.textView.tintColor = kGlobalColor;
    self.textView.scrollEnabled = YES;
    self.textView.text = text;
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
//    self.headView = [UIImage initView];
//    headView.scrollViewHeight.constant = DEVICE_SIZE.width;
//    headView.scrollView.pagingEnabled = YES;
//    headView.scrollView.delegate = self;
//    self.headView = headView;
//    self.headScrollView = headView.scrollView;
//    [self.scrollView addSubview:headView];
//    
//    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.height.mas_equalTo(DEVICE_SIZE.width);
//        make.width.mas_equalTo(DEVICE_SIZE.width);
//        self.headerViewH = DEVICE_SIZE.width;
//    }];
}
#pragma mark - Getter & Setter

-(NSMutableArray *)detailArray {
    
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}
@end
