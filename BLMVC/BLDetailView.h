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

@interface BLDetailView : UIView
@property (weak, nonatomic) id<BLDetailViewDelegate> delegate;// 委托
@property (strong, nonatomic) BLPost *post;
@property (strong, nonatomic) UIButton *button;// 按钮
@property (strong, nonatomic) UIImageView *imageView;// 图片
@end

@protocol BLDetailViewDelegate <NSObject>

- (void)detailView:(BLDetailView *)detailView touchAction:(id)sender;

@end
