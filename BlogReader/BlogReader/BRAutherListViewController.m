//
//  BRAutherListViewController.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRAutherListViewController.h"
#import "BRAutherModel.h"
#import "BRAutherTableViewCell.h"
#import "BRBlogListViewController.h"

static NSString *autherCellId = @"BRAutherCellId";
@interface BRAutherListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray<BRAutherModel*> *autherList;
@property(nonatomic, assign)NSInteger pageNo;

@end

@implementation BRAutherListViewController

#pragma mark- lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"博主";
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    [self loadCachedData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma getter
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [self.view addSubview:_tableView];
        [_tableView registerClass:BRAutherTableViewCell.class forCellReuseIdentifier:autherCellId];
        
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
        [_tableView.footer setHidden:YES];
        _tableView.tableFooterView = [UIView new];
        _autherList = [NSMutableArray array];
    }
    return _tableView;
}

- (void)refreshHeader{
    [self refreshDataWithHeader:YES];
}

- (void)refreshFooter{
    [self refreshDataWithHeader:NO];
}

- (void)refreshDataWithHeader:(BOOL)header{
    if (header) {
        _pageNo = 1;
    } else {
        _pageNo++;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSNumber numberWithInteger:_pageNo] forKey:@"pageNo"];
    [dic setValue:[NSNumber numberWithInteger:kItemCountPerPage] forKey:@"pageNumber"];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [sessionManager GET:@"/autherList" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray<BRAutherModel*> *blogArray = [BRAutherModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (header) {
            [_autherList removeAllObjects];
            [BRAutherModel deleteWithWhere:nil];
        }
        [BRAutherModel insertArrayByAsyncToDB:blogArray];
        [_autherList addObjectsFromArray:blogArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (blogArray.count<kItemCountPerPage) {
                [_tableView.footer setHidden:YES];
            } else {
                [_tableView.footer setHidden:NO];
            }
            if (header) {
                [_tableView.header endRefreshing];
            } else {
                [_tableView.footer endRefreshing];
            }
            [_tableView eb_showDefaultEmptyView:_autherList.count==0];
            [_tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (header) {
                [_tableView.header endRefreshing];
            } else {
                [_tableView.footer endRefreshing];
            }
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            [_tableView eb_showDefaultEmptyView:_autherList.count==0];
        });
    }];
}

//获取缓存数据
- (void)loadCachedData{
    _autherList = [BRAutherModel searchWithWhere:nil];
    [_tableView reloadData];
    [_tableView.header beginRefreshing];
}

#pragma mark- tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _autherList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BRAutherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:autherCellId];
    cell.autherModel = _autherList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BRBlogListViewController *blogListVc = [[BRBlogListViewController alloc] init];
    blogListVc.auther = _autherList[indexPath.row].auther;
    blogListVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:blogListVc animated:YES];
}

@end
