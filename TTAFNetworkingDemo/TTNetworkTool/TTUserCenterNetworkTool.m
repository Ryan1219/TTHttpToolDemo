//
//  TTUserCenterNetworkTool.m
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTUserCenterNetworkTool.h"
#import "TTHttpTool.h"
#import "MJExtension.h"

@implementation TTUserCenterNetworkTool

/**
 *  请求用户信息 GET
 *  @param param   请求参数
 *  @param success 请求成功返回结果
 *  @param failure 请求失败返回结果
 */
+ (void)getUserInfo:(TTParamsBase *)params success:(void (^)(TTResultBase *))success failure:(void (^)(NSError *))failure {
    
    NSString *url = @""; //请求路径
    [TTHttpTool getWithURL:url params:params.mj_keyValues success:^(id json) {
        TTResultBase *result = [TTResultBase mj_objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end















































