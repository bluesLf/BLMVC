//
//  BLDetailVC.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDetailView.h"

@class BLPost;

/**
 详情
 */
@interface BLDetailVC : UIViewController <BLDetailViewDelegate>
@property (strong, nonatomic) BLPost *post;// 发布对象
@property (strong, nonatomic) BLDetailView *detailView;// 详细视图
- (id)initWithPost:(BLPost *)post;// 初始化
@end
