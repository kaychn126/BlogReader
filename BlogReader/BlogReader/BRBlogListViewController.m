//
//  BRBlogListViewController.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRBlogListViewController.h"
#import "BRBlogModel.h"
#import "BRBlogTableViewCell.h"
#import "BRWebViewController.h"

static NSString *blogCellId = @"BRBlogTableViewCellId";

@interface BRBlogListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray<BRBlogModel*> *blogList;
@property(nonatomic, assign)NSInteger pageNo;
@end

@implementation BRBlogListViewController

#pragma mark- lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_auther) {
        self.title = _auther;
    } else {
        self.title = @"博客";
    }
    
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
        _tableView.rowHeight = 70;
        [self.view addSubview:_tableView];
        [_tableView registerClass:BRBlogTableViewCell.class forCellReuseIdentifier:blogCellId];
        
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
        [_tableView.footer setHidden:YES];
        _tableView.tableFooterView = [UIView new];
        _blogList = [NSMutableArray array];
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- queryData

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
    [dic setValue:_auther forKey:@"auther"];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [sessionManager GET:@"/articleList" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray<BRBlogModel*> *blogArray = [BRBlogModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (header) {
            [_blogList removeAllObjects];
            if (_auther) {
                [BRBlogModel deleteWithWhere:[NSString stringWithFormat:@"auther='%@'",_auther]];
            }else {
                [BRBlogModel deleteWithWhere:nil];
            }
        }
        [BRBlogModel insertArrayByAsyncToDB:blogArray];
        [_blogList addObjectsFromArray:blogArray];
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
            [_tableView eb_showDefaultEmptyView:_blogList.count==0];
            [_tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (header) {
                [_tableView.header endRefreshing];
            } else {
                [_tableView.footer endRefreshing];
            }
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            [_tableView eb_showDefaultEmptyView:_blogList.count==0];
        });
    }];
}

//获取缓存数据
- (void)loadCachedData{
    if (_auther) {
        _blogList = [BRBlogModel searchWithWhere:[NSString stringWithFormat:@"auther='%@'",_auther]];
    }else {
        _blogList = [BRBlogModel searchWithWhere:nil];
    }
    [_tableView reloadData];
    [_tableView.header beginRefreshing];
}

#pragma mark- tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _blogList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BRBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blogCellId];
    cell.blogModel = _blogList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BRWebViewController *webVc = [[BRWebViewController alloc] init];
    webVc.webUrl = _blogList[indexPath.row].url;
    webVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
