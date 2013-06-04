//
//  BLDetailView.m
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLDetailView.h"

@implementation BLDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(100, 40, 120, 40);
        [_button setTitle:@"点我吧" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        //
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 240)];
        // addSubview
        [self addSubview:_button];
        [self addSubview:_imageView];
    }
    return self;
}

#pragma mark - Actions
- (void)touchAction:(UIButton *)button {// 事件委托到控制器实现
    if ([self.delegate respondsToSelector:@selector(detailView:touchAction:)]) {
        [self.delegate detailView:self touchAction:button];
    }
}

#pragma mark - Setters
- (void)setPost:(BLPost *)post {// 利用Setter更新视图
    _post = post;
    
}

@end
