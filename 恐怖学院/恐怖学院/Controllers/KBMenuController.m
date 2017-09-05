//
//  KBMenuController.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBMenuController.h"
#import "KBCatagoryController.h"
#import "KBCollectionController.h"
#import "KBAboutController.h"

#import "KBMenuModel.h"

#import "KBMenuCell.h"
#import "KBMenuFooterView.h"

@interface KBMenuController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, assign) CGFloat footerHeight;
@end

@implementation KBMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMenuWidth, DEVICE_SIZE.height)];
    imageview.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageview];
    MTLog(@"Menu");
    [self initData];
    [self initUI];
    [self setTableView];
}
- (void)initData {
    
    [self.datas addObject:@[[KBMenuModel title:@"首页" action:@selector(runMain)]]];
    [self.datas addObject:@[[KBMenuModel title:@"收藏" action:@selector(runCollect)]]];
    [self.datas addObject:@[[KBMenuModel title:@"鼓励" action:@selector(runEncourage)]]];
    [self.datas addObject:@[[KBMenuModel title:@"关于" action:@selector(runAbout)]]];
}
- (void)initUI {
    
    
}
- (void)setTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMenuWidth, DEVICE_SIZE.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled =NO;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = (NSArray *)self.datas[section];
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 40 : 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    self.footerHeight = DEVICE_SIZE.height - [KBMenuCell heightForCell]* 4 - 10* 3 - 40;
    return section == 3 ? self.footerHeight :CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return [KBMenuCell heightForCell];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    KBMenuFooterView *footer = [[KBMenuFooterView alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height - self.footerHeight, kMenuWidth, self.footerHeight)];
    
    if (section == self.datas.count - 1) {
        return footer;
    }else {
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KBMenuCell * cell = [KBMenuCell cell:tableView];
    cell.model = [[self.datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.isLastCellInSection = indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1;
    return cell;    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KBMenuModel *model = [[self.datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([self respondsToSelector:model.action]) {
        [self performSelector:model.action afterDelay:0];
    }
}

#pragma mark - Getter

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

#pragma mark - UITableView Actions
- (void)runMain {
    
    KBCatagoryController* cateVC = [[KBCatagoryController alloc] init];
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:cateVC animated:NO];
    [self closeDrawre];
}
- (void)runCollect {
    
    KBCollectionController* collVC = [[KBCollectionController alloc] init];
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:collVC animated:NO];
    [self closeDrawre];
}
- (void)runEncourage {

    //跳转AppStore
    [self closeDrawre];
}
- (void)runAbout {
    
    KBAboutController* abouVC = [[KBAboutController alloc] init];
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:abouVC animated:NO];
    [self closeDrawre];
}

#pragma mark - 关闭我们的抽屉
- (void)closeDrawre {
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}
@end
