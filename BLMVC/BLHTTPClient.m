//
//  BLHTTPClient.m
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLHTTPClient.h"

#define kURLString @"https://alpha-api.app.net/"

@implementation BLHTTPClient

+ (BLHTTPClient *)sharedClient {
    static BLHTTPClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BLHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kURLString]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        // 设置HTTP Header
    }
    return self;
}

@end
