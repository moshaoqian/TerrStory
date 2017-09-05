//
//  KBListController.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBListController.h"
#import "KBDetailController.h"

#import "KBListCell.h"

#import "KBModel.h"

@interface KBListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)NSMutableArray* listArray;

@end

@implementation KBListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableGrayColor;
    
    self.title = self.categoryModel.title;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"t_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self updateData];
    [self setTableView];
    
}
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)updateData {
    
    ListParams* params = [ListParams alloc];
    params.page = @"1";
    params.type = self.categoryModel.type;
    
    [ShowApiClient post:SHOWAPI_LIST_URL params:[params buildParams] completion:^(id result) {
        
        NSDictionary *dataDict = result[@"showapi_res_body"][@"pagebean"];
        NSArray*dataArray = dataDict[@"contentlist"];
        [self.listArray removeAllObjects];
        
        for (NSDictionary *dict in dataArray) {
            KBListModel *model = [[KBListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.listArray addObject:model];
        }
        [self.tableView reloadData];
        [self endRefreshing];
    }];
}
- (void)beginRefreshing {
    
    [self updateData];
}

- (void)endRefreshing {
    
    [self.tableView.mj_header endRefreshing];
}
- (void)setTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self beginRefreshing];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [KBListCell heightForCell];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KBListCell * cell = [KBListCell cell:tableView];
    cell.model = [self.listArray objectAtIndex:indexPath.row];
    cell.isLastCellInSection = indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KBListModel *model = [self.listArray objectAtIndex:indexPath.row];
    KBDetailController* controller = [[KBDetailController alloc] init];
    controller.detailId = model.objectId;
    controller.url = model.img;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - Getter & Setter

-(NSMutableArray *)listArray {
    
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
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
