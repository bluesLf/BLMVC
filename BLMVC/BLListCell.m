//
//  BLListCell.m
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLListCell.h"
#import "BLPost.h"
#import "BLUser.h"
#import "UIImageView+AFNetworking.h"

@interface BLListCell ()
@property (strong, nonatomic) UIImageView *iconImageView;// 头像
@property (strong, nonatomic) UILabel *usernameLabel;// 用户名
@property (strong, nonatomic) UILabel *postTextLabel;// 发布内容
@end

@implementation BLListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        //
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 240, 20)];
        _usernameLabel.backgroundColor = [UIColor clearColor];
        _usernameLabel.textColor = [UIColor blackColor];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:18];
        //
        _postTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 240, 0)];
        _postTextLabel.backgroundColor = [UIColor clearColor];
        _postTextLabel.textColor = [UIColor grayColor];
        _postTextLabel.font = [UIFont systemFontOfSize:16];
        _postTextLabel.numberOfLines = 0;
        //
        [self.contentView addSubview:_iconImageView];
        [self.contentView addSubview:_usernameLabel];
        [self.contentView addSubview:_postTextLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {// 设置选中背景
    if (highlighted) {
        UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        selectedBackgroundView.image = [UIImage imageNamed:@"listbj_over"];
        self.backgroundView = selectedBackgroundView;
    } else {
        self.backgroundView = nil;
    }
}

- (void)layoutSubviews {// 视图布局
    [super layoutSubviews];
    CGRect postTextLabelFrame = self.postTextLabel.frame;
    postTextLabelFrame.size.height = [[self class] heightForCellWithPost:self.post] - 50;
    self.postTextLabel.frame = postTextLabelFrame;
}

#pragma mark - Public methods
+ (CGFloat)heightForCellWithPost:(BLPost *)post {
    CGSize sizeToFit = [post.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(240, CGFLOAT_MAX)];
    return fmaxf(70, sizeToFit.height + 50);
}

#pragma mark - Setters
- (void)setPost:(BLPost *)post {// 利用Setter更新视图
    _post = post;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.post.user.avatarImageUrlStr] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    self.usernameLabel.text = self.post.user.username;
    self.postTextLabel.text = self.post.text;
    [self setNeedsLayout];// 更新视图布局
}

@end
