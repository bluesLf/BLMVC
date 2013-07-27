//
//  BLListCell.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLPost;

/**
 列表单元。
 1、提供实体对象，用于更新视图。
 2、提供高度公共方法。
 */
@interface BLListCell : UITableViewCell
@property (strong, nonatomic) BLPost *post;
+ (CGFloat)heightForCellWithPost:(BLPost *)post;// Cell的高度
@end
