//
//  BLPost.h
//  BLMVC
//
//  Created by yhw on 13-6-4.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLUser;// 使用`@class`声明类，然后在.m里面`#import`

/**
 发布实体。
 使用`initWithAttributes:`解析JSON数据生成对象。
 不同的网络请求可以创建`initXXXWithAttributes:`解析JSON数据生成对象。
 使用`postsWithPath:parameters:block:`进行网络请求，使用`initWithAttributes:`解析JSON数据，使用BLResultSet装解析生成的对象。
 */
@interface BLPost : NSObject
@property (strong, nonatomic) NSString *postID;// 发布ID
@property (strong, nonatomic) NSString *text;// 发布内容
@property (strong, nonatomic) BLUser *user;// 用户对象
- (id)initWithAttributes:(NSDictionary *)attributes;// 解析JSON数据生成对象
//- (id)initXXXWithAttributes:(NSDictionary *)attributes;// 解析JSON数据生成对象
+ (void)postsWithPath:(NSString *)path parameters:(NSDictionary *)parameters block:(void (^)(BLResultSet *resultSet, NSError *error))block;// 获取发布内容
@end
