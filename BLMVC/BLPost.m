//
//  BLPost.m
//  BLMVC
//
//  Created by yhw on 13-6-4.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLPost.h"
#import "BLUser.h"

@implementation BLPost

- (id)initWithAttributes:(NSDictionary *)attributes {
    if (self = [super init]) {
        _postID = attributes[@"id"];
        _text = attributes[@"text"];
        _user = [[BLUser alloc] initWithAttributes:attributes[@"user"]];
    }
    return self;
}

+ (void)postsWithPath:(NSString *)path parameters:(NSDictionary *)parameters block:(void (^)(BLResultSet *resultSet, NSError *error))block {
    [[BLHTTPClient sharedClient] getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"urlStr = %@%@%@",[BLHTTPClient sharedClient].baseURL, path, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:[BLHTTPClient sharedClient].stringEncoding]);// 打印请求链接
        NSError *error = nil;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options: kNilOptions error:&error];
        BLResultSet *resultSet = [[BLResultSet alloc] initWithDataArray:jsonDict];// 默认取`data`字段数据，最好还是指定字段名称`jsonDict["data"]`
        resultSet.response = [[Response alloc] initWithAttributes:jsonDict];// 响应对象，包括结果编码和描述
        [resultSet.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {// 不管返回的是字典数据还是数组数据，都存放在数组里面，可以屏蔽字典和数组数据结构，保证代码的一致性
            BLPost *post = [[BLPost alloc] initWithAttributes:obj];
            [resultSet.resultArray addObject:post];
        }];
//        NSLog(@"resultArray  = %@", resultSet.resultArray);// 打印结果数组
        if (block) {
            block(resultSet, error);// 返回结果
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);// 返回结果
        }
    }];
}

#pragma mark - Description
- (NSString *)description {// 格式化类描述，打印各个字段的值
    return [NSString stringWithFormat:
            @"<%@"
            @" _postID: '%@'"
            @" _text: '%@'"
            @" _user: '%@'"
            @">",
            [super description],
            _postID,
            _text,
            _user
            ];
}

@end
