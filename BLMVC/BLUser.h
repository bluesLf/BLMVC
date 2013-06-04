//
//  BLUser.h
//  BLMVC
//
//  Created by yhw on 13-6-4.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户实体。
 使用`initWithAttributes:`解析JSON数据生成对象。
 不同的网络请求可以创建`initXXXWithAttributes:`解析JSON数据生成对象。
 */
@interface BLUser : NSObject
@property (strong, nonatomic) NSString *userID;// 用户ID
@property (strong, nonatomic) NSString *username;// 用户名称
@property (strong, nonatomic) NSString *avatarImageUrlStr;// 头像链接
@property (strong, nonatomic) NSString *coverImageUrlStr;// 封面链接
- (id)initWithAttributes:(NSDictionary *)attributes;// 解析JSON数据生成对象
//- (id)initXXXWithAttributes:(NSDictionary *)attributes;// 解析JSON数据生成对象
@end
