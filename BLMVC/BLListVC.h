//
//  BLListVC.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 列表
 */
@interface BLListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *listTableView;// 列表
@property (strong, nonatomic) NSArray *posts;// 发布内容
//@property (assign, nonatomic) NSInteger page;// 分页
//@property (assign, nonatomic) NSInteger totalPage;// 分页
@end
