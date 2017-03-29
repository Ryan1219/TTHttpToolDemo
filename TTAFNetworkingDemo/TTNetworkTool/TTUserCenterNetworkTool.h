//
//  TTUserCenterNetworkTool.h
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTResultBase.h"
#import "TTParamsBase.h"

// 用户个人中心相关的接口
@interface TTUserCenterNetworkTool : NSObject

/**
 *  请求用户信息接口 GET
 *  @param param   请求参数
 *  @param success 请求成功返回结果
 *  @param failure 请求失败返回结果
 */
+ (void)getUserInfo:(TTParamsBase *)params success:(void (^)(TTResultBase *result))success failure:(void (^)(NSError *error))failure;

@end
