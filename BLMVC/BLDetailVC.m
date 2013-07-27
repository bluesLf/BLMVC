//
//  BLDetailVC.m
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLDetailVC.h"
#import "BLPost.h"
#import "BLUser.h"
#import "UIImageView+WebCache.h"

@interface BLDetailVC ()

@end

@implementation BLDetailVC

- (id)initWithPost:(BLPost *)post {
    if (self = [super init]) {
        _post = post;
    }
    return self;
}

#pragma mark - View lifecycle
- (void)loadView {// 手工构建视图，使用变量_XXX，其他地方使用属性self.XXX访问
    [super loadView];
    // 兼容iPhone5，使用视图bounds构建视图
    CGRect bounds = self.view.bounds;
    bounds.size.height -= 44;
    // 构建视图
    _detailView = [[BLDetailView alloc] initWithFrame:bounds];
    _detailView.delegate = self;// 设置视图的委托delegate
    // addSubview
    [self.view addSubview:_detailView];
}

- (void)viewDidLoad {// 设置控制器`title`、加载数据
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"详情";
    [self reload];// 加载数据
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Reload data
- (void)reload {// 加载详情数据
    __weak __typeof(self) weakSelf;// 避免block循环引用
    __block UIActivityIndicatorView *activityIndicatorView = nil;
    // 下载图片
    [self.detailView.imageView setImageWithURL:[NSURL URLWithString:self.post.user.coverImageUrlStr] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSUInteger receivedSize, long long expectedSize) {
        NSLog(@"%u %lld", receivedSize, expectedSize);
        if (nil == activityIndicatorView) {
            activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicatorView.center = CGPointMake(weakSelf.detailView.imageView.center.x - weakSelf.detailView.imageView.frame.origin.x, weakSelf.detailView.imageView.center.y - weakSelf.detailView.imageView.frame.origin.y);
            [weakSelf.detailView.imageView addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (nil != activityIndicatorView) {
            [activityIndicatorView stopAnimating];
            [activityIndicatorView removeFromSuperview];
            activityIndicatorView = nil;
        }
    }];
}

#pragma mark - BLDetailViewDelegate
- (void)detailView:(BLDetailView *)detailView touchAction:(id)sender {// 详情视图委托实现
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"我是按钮" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道", nil];
    [alertView show];
}

@end
