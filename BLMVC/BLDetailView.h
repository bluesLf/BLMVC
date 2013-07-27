//
//  BLDetailView.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLDetailViewDelegate;
@class BLPost;

/**
 详情视图。
 1、通过delegate委托在控制器里面实现事件。
 2、提供实体对象用于更新视图。
 3、用于构建复杂的视图，分离视图构建可以使代码逻辑清晰，但不是必要条件，因为复用性有待验证。
 */
@interface BLDetailView : UIView
@property (weak, nonatomic) id<BLDetailViewDelegate> delegate;// 委托
@property (strong, nonatomic) BLPost *post;// 发布内容实体
@property (strong, nonatomic) UIButton *button;// 按钮
@property (strong, nonatomic) UIImageView *imageView;// 图片
@end

@protocol BLDetailViewDelegate <NSObject>

- (void)detailView:(BLDetailView *)detailView touchAction:(id)sender;

@end
