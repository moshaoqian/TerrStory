//
//  KBCatagoryController.m
//  恐怖学院
//
//  Created by MiaoTianyu on 2017/9/1.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "KBCatagoryController.h"
#import "KBListController.h"
#import "KBDetailController.h"

#import "KBCatagoryBannerCell.h"
#import "KBCatagoryCell.h"
#import "KBCatagoryReusableView.h"

@interface KBCatagoryController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,KBCatagoryBannerCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *recmomandArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;

@end

@implementation KBCatagoryController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"首页";
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    [self setUpCatagoty];
    [self setupUI];
    
    [self.collectionView registerClass:[KBCatagoryBannerCell class] forCellWithReuseIdentifier:[KBCatagoryBannerCell reuseIdentifier]];
    [self.collectionView registerClass:[KBCatagoryCell class] forCellWithReuseIdentifier:[KBCatagoryCell reuseIdentifier]];
    [self.collectionView registerClass:[KBCatagoryReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[KBCatagoryReusableView reuseIdentifier]];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self beginRefreshing];
}
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)setUpCatagoty {
    
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"短篇" title:@"短篇" type:@"dp"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"长篇" title:@"长篇" type:@"cp"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"校园" title:@"校园" type:@"xy"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"医院" title:@"医院" type:@"yy"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"宅院" title:@"宅院" type:@"jl"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"民间" title:@"民间" type:@"mj"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"灵异" title:@"灵异" type:@"ly"]];
    [self.categoryArray addObject:[self setCatagoryModelWithImg:@"原创" title:@"原创" type:@"yc"]];

}
- (KBCategoryModel*)setCatagoryModelWithImg: (NSString*)img title:(NSString*)title type:(NSString*)type{
    
    KBCategoryModel* model = [[KBCategoryModel alloc] init];
    model.img = img;
    model.title = title;
    model.type = type;
    return model;
}
- (void)setupUI {
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)beginRefreshing {
    
    [self updateData];
}

- (void)endRefreshing {
    
    [self.collectionView.mj_header endRefreshing];
}

- (void)updateData {
    
    ListParams* params = [ListParams alloc];
    params.page = @"1";
    params.type = @"xy";
    
    [ShowApiClient post:SHOWAPI_LIST_URL params:[params buildParams] completion:^(id result) {
        
        NSDictionary *dataDict = result[@"showapi_res_body"][@"pagebean"];
        NSArray*dataArray = dataDict[@"contentlist"];
        [self.recmomandArray removeAllObjects];
        
        for (NSDictionary *dict in dataArray) {
            KBListModel *model = [[KBListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.recmomandArray addObject:model];
        }
        [self.collectionView reloadData];
        [self endRefreshing];
    }];
}
#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.categoryArray.count;
    }
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [KBCatagoryBannerCell sizeForCell];
    } else if (indexPath.section == 1) {
        return [KBCatagoryCell sizeForCell];
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(DEVICE_SIZE.width, 58);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
       KBCatagoryReusableView *categoryHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[KBCatagoryReusableView reuseIdentifier] forIndexPath:indexPath];
        return categoryHeaderView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KBCatagoryBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[KBCatagoryBannerCell reuseIdentifier] forIndexPath:indexPath];
        cell.recommandArray = self.recmomandArray;
        cell.bannerDelegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        KBCatagoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[KBCatagoryCell reuseIdentifier] forIndexPath:indexPath];
        cell.categoryModel = self.categoryArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        KBCategoryModel *model = [self.categoryArray objectAtIndex:indexPath.row];
        KBListController* viewController = [[KBListController alloc] init];
        viewController.categoryModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        KBCatagoryCell *cell = (KBCatagoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setHighlighted:YES animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        KBCatagoryCell *cell = (KBCatagoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setHighlighted:NO animated:YES];
    }
}

#pragma mark - KBCatagoryBannerCellDelegate

- (void)catagoryBannerCell:(KBCatagoryBannerCell *)cell didSelectItemAtIndex:(NSInteger)index {
    
    KBDetailController *viewController = [[KBDetailController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Getter & Setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)recmomandArray {
    if (!_recmomandArray) {
        _recmomandArray = [NSMutableArray array];
    }
    return _recmomandArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}
@end

