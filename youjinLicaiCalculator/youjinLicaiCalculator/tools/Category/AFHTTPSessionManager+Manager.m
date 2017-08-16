//
//  AFHTTPSessionManager+Manager.m
//  BuDeJie
//
//  Created by 李江波 on 16/10/19.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import "AFHTTPSessionManager+Manager.h"

@implementation AFHTTPSessionManager (Manager)

+ (instancetype)bo_manager {
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // [AFJSONResponseSerializer serializer] : JSON
    // [AFOnoResponseSerializer XMLResponseSerializer] ： XML
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",  nil];
    mgr.responseSerializer = response;
    return mgr;
}
@end
