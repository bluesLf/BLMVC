//
//  BLUser.m
//  BLMVC
//
//  Created by yhw on 13-6-4.
//  Copyright (c) 2013年 YHW. All rights reserved.
//

#import "BLUser.h"

@implementation BLUser

- (id)initWithAttributes:(NSDictionary *)attributes {
    if (self = [super init]) {
        _userID = attributes[@"id"];
        _username = attributes[@"username"];
        _avatarImageUrlStr = attributes[@"avatar_image.url"];
        _coverImageUrlStr = [attributes valueForKeyPath:@"cover_image.url"];
    }
    return self;
}

#pragma mark - Description
- (NSString *)description {// 用于打印实体属性
    return [NSString stringWithFormat:
            @"<%@"
            @" _userID: '%@'"
            @" _username: '%@'"
            @" _avatarImageUrlStr: '%@'"
            @" _coverImageUrlStr: '%@'"
            @">",
            [super description],
            _userID,
            _username,
            _avatarImageUrlStr,
            _coverImageUrlStr
            ];
}

@end
