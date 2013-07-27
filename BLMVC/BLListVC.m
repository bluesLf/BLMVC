//
//  BLListVC.m
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLListVC.h"
#import "BLPost.h"
#import "BLListCell.h"
#import "BLDetailVC.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"

@interface BLListVC () {
    __strong UIActivityIndicatorView *_activityIndicatorView;// 网络请求进度
}
@end

@implementation BLListVC

#pragma mark - View lifecycle
- (void)loadView {// 手工构建视图，使用变量_XXX，其他地方使用属性self.XXX访问
    [super loadView];
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)];// 刷新
    //
    CGRect bounds = self.view.bounds;
    bounds.size.height -= 44;
    // 构建视图
    _listTableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    // addSubview
    [self.view addSubview:_listTableView];
    // 初始化
//    _page = 0;
//    _totalPage = 0;
}

- (void)viewDidLoad {// 设置控制器`title`、加载数据
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"列表";
    //
    __weak __typeof(self) weakSelf = self;// 避免block循环引用
    [self.listTableView addPullToRefreshWithActionHandler:^{
        [weakSelf reloadPosts];
        NSDate *date = [[NSDate alloc] init];
        NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
        [weakSelf.listTableView.pullToRefreshView setSubtitle:dateString forState:SVPullToRefreshStateStopped];
    }];
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DefaultCellIdentifier";
    BLListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[BLListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.post = self.posts[indexPath.row];// 通过setter更新`Cell`
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    BLDetailVC *detailVC = [[BLDetailVC alloc] initWithPost:self.posts[indexPath.row]];// 详情控制器
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BLListCell heightForCellWithPost:self.posts[indexPath.row]];
}

#pragma mark - Reload data
- (void)reload {
    [self.listTableView triggerPullToRefresh];
}
- (void)reloadPosts {// 加载列表数据
    [SVProgressHUD show];
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSString *path = @"stream/0/posts/stream/global";
    NSDictionary *parameters = nil;
    [BLPost postsWithPath:path parameters:parameters block:^(BLResultSet *resultSet, NSError *error) {// 通过该方法，集中逻辑代码
        if (error) {// 处理错误
            NSLog(@"error = %@", error);
        } else {
            if (resultSet.resultArray.count > 0) {// 有数据
                self.posts = resultSet.resultArray;
                [self.listTableView reloadData];// 更新视图
            }
        }
        if (0 == self.posts) {// 没有数据
            // 设置空视图
        }
        [_activityIndicatorView stopAnimating];
        [self.listTableView.pullToRefreshView stopAnimating];
        [SVProgressHUD dismiss];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

#pragma mark - Load data
- (void)loadData {// 分页请求
//    ++self.page;
//    [self loadDataWithPage:self.page];
}

- (void)loadDataWithPage:(NSInteger)page {// 分页请求
    //
}

#pragma mark - Getters
- (NSArray *)posts {// 延迟初始化对象，使用属性self.XXX访问
    if (!_posts) {
        _posts = [[NSArray alloc] init];
    }
    return _posts;
}

@end
