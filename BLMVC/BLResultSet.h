//
//  BLResultSet.h
//  BlShanCap
//
//  Created by yhw on 13-1-6.
//
//

#import <Foundation/Foundation.h>

@class Page;
@class Response;

/**
 网络请求结果集。
 1、使用`dataArray`屏蔽数组或者字典返回数据，使用`resultArray`装解析JSON的对象。
 2、支持分页对象和响应对象。
 */
@interface BLResultSet : NSObject
@property (strong, nonatomic) id dataArray;// 用于屏蔽数组或者字典 an array using for shielding NSArray and NSDictionary, add "data"
@property (strong, nonatomic) NSMutableArray *resultArray;// 装解析JSON的对象 using for "data", add bean(s)
@property (strong, nonatomic) Page *page;// 分页对象 using for "page"
@property (strong, nonatomic) Response *response;// 响应结果码和结果信息 Response "status" and "msg"
- (id)init;// 初始化 init method
- (id)initWithDataArray:(id)dataArray;// 使用`dataArray`装原始的JSON数据
- (id)initWithPage:(Page*)page;// 使用分页对象初始化
- (id)initWithDataArray:(id)dataArray page:(Page*)page;// `dataArray`和分页对象
@end

/**
 分页对象
 */
@interface Page : NSObject
@property (assign, nonatomic) NSInteger totalPage;// 总页码 totalPage
- (id)init;// 初始化 init method
- (id)initWithTotalPage:(NSInteger)totalPage;// 使用总页码初始化 init method
- (id)initWithAttributes:(NSDictionary*)attributes;// 使用JSON数据初始化 init with NSDictionary attributes
@end

/**
 响应对象
 */
@interface Response : NSObject
@property (assign, nonatomic) NSInteger status;// 结果码 Response status
@property (strong, nonatomic) NSString *message;// 结果信息 Response message
- (id)initWithAttributes:(NSDictionary*)attributes;// 使用JSON数据初始化 init with NSDictionary attributes
@end