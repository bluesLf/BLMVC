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
        BLResultSet *resultSet = [[BLResultSet alloc] initWithDataArray:jsonDict];// 默认取`data`字段数据
        resultSet.response = [[Response alloc] initWithAttributes:jsonDict];
        [resultSet.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BLPost *post = [[BLPost alloc] initWithAttributes:obj];
            [resultSet.resultArray addObject:post];
        }];
        NSLog(@"resultArray  = %@", resultSet.resultArray);// 打印结果数组
        if (block) {
            block(resultSet, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

#pragma mark - Description
- (NSString *)description {
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
