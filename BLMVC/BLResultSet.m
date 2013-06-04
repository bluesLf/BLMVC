//
//  BLResultSet.m
//  BlShanCap
//
//  Created by yhw on 13-1-6.
//
//

#import "BLResultSet.h"

#define PAGE_TOTAL_NUMBER @"totalPage"

@interface BLResultSet ()
- (void)shieldArrayAndDictionary:(id)dataArray;// 屏蔽`NSArray`和`NSDictionary` for shielding NSArray and NSDictionary
@end
@implementation BLResultSet

#pragma mark - Private methods
- (void)shieldArrayAndDictionary:(id)dataArray {
    if ([dataArray isKindOfClass:[NSDictionary class]]) {
#warning 如果`data`字段不存在会有问题!!!使用时需要指定字段名称!!!
        if ([dataArray objectForKey:@"data"]) {// 默认是`data`字典
            dataArray = [dataArray objectForKey:@"data"];
        }
    }
    if ([dataArray isKindOfClass:[NSDictionary class]]) {
        [_dataArray addObject:dataArray];
    } else {
        if (_dataArray != dataArray) {
            _dataArray = dataArray;
        }
    }
}

#pragma mark - Public methods
- (void)setDataArray:(id)dataArray {
    [self shieldArrayAndDictionary:dataArray];
}

- (id)init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        _resultArray = [[NSMutableArray alloc] init];
        _page = [[Page alloc] init];
    }
    return self;
}

- (id)initWithDataArray:(id)dataArray {
    return [self initWithDataArray:dataArray page:[[Page alloc] init]];
}

- (id)initWithPage:(Page*)page {
    return [self initWithDataArray:[[NSMutableArray alloc] init] page:page];
}

- (id)initWithDataArray:(id)dataArray page:(Page *)page {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        _resultArray = [[NSMutableArray alloc] init];
        _page = page;
        [self shieldArrayAndDictionary:dataArray];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@"
            @" _response: '%@'"
            @" _resultArray: '%@'"
            @" _page: '%@'"
            @">",
            [super description],
            _response,
            _resultArray,
            _page
            ];
}

@end

@implementation Page

- (id)init {
    if (self =[super init]) {
        _totalPage = 0;
    }
    return self;
}

- (id)initWithTotalPage:(NSInteger)totalPage {
    if (self =[super init]) {
        _totalPage = totalPage;
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary*)attributes {
    if (self =[super init]) {
        NSDictionary *pageDict = [attributes objectForKey:@"page"];// 默认字段是`page`
        _totalPage = [[pageDict objectForKey:PAGE_TOTAL_NUMBER] intValue];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@"
            @" _totalPage: '%i'"
            @">",
            [super description],
            _totalPage
            ];
}

@end

@implementation Response

- (id)initWithAttributes:(NSDictionary*)attributes {
    if (self =[super init]) {
        NSString *statusStr = [attributes objectForKey:@"code"];// 默认字段是`code`
        _status = [statusStr intValue];
        _message = [attributes objectForKey:@"msg"];// 默认字段是`msg`
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@"
            @" _status: '%i'"
            @" _message: '%@'"
            @">",
            [super description],
            _status,
            _message
            ];
}

@end


