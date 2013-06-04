//
//  BLHTTPClient.h
//  BLMVC
//
//  Created by yhw on 13-6-2.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "AFHTTPClient.h"

/**
 网络请求。
 */
@interface BLHTTPClient : AFHTTPClient
+ (BLHTTPClient *)sharedClient;
@end
