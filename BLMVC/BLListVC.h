//
//  BLListVC.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 列表控制器。
 1、目前上下拉控件使用`https://github.com/samvermette/SVPullToRefresh.git`，进度控件使用`https://github.com/samvermette/SVProgressHUD.git`和`https://github.com/jdg/MBProgressHUD.git`
 */
@interface BLListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *listTableView;// 列表
@property (strong, nonatomic) NSArray *posts;// 发布内容
//@property (assign, nonatomic) NSInteger page;// 分页
//@property (assign, nonatomic) NSInteger totalPage;// 分页
@end
