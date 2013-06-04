//
//  BLListCell.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLPost;

@interface BLListCell : UITableViewCell
@property (strong, nonatomic) BLPost *post;
+ (CGFloat)heightForCellWithPost:(BLPost *)post;// Cell的高度
@end
