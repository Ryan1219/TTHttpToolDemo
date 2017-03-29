//
//  TTHttpTool.m
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTHttpTool.h"
#import "AFNetworking.h"

#define kTokenInvalidate @"tokenInvalidate"

@implementation TTHttpTool

// AFNetworking默认的请求与响应
//self.requestSerializer = [AFHTTPRequestSerializer serializer];
//self.responseSerializer = [AFJSONResponseSerializer serializer];

+ (AFHTTPSessionManager *)httpSessionManager:(AFHTTPRequestSerializer *)requestSerializer responseSerializer:(AFHTTPResponseSerializer *)responseSerializer{
    
    //创建请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60; //设置请求超时
    
    // 直接使用服务器返回的数据，不做任何解析
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 解析服务器返回的json数据
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    // 解析服务器返回的xml数据
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];

    if (requestSerializer != nil) {
        [manager setRequestSerializer:requestSerializer];
    }
   
    if (responseSerializer != nil) {
        [manager setResponseSerializer:responseSerializer];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 如果公司后台要求请求头带上用户token,email,uuid,client，这些数据必须请求接口拿到
//    [manager.requestSerializer setValue:@"token" forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setValue:@"email" forHTTPHeaderField:@"email"];
//    [manager.requestSerializer setValue:@"uuid" forHTTPHeaderField:@"uuid"];
//    [manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"client"];
    
    return manager;
}

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  json
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postJsonWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [self httpSessionManager:[AFJSONRequestSerializer serializer] responseSerializer:nil];
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 本段代码根据错误码(后台给定)判断用户登录是否失效
            [self checkTokenInvalidate:responseObject];
            NSLog(@"url=%@,请求返回结果:%@",url,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            NSLog(@"url=%@,请求失败结果:%@",url,error);
            failure(error);
        }
    }];
}


/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [self httpSessionManager:nil responseSerializer:nil];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (TTFormData *subFormData in formDataArray) {
            [formData appendPartWithFileData:subFormData.data name:subFormData.name fileName:subFormData.filename mimeType:subFormData.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 本段代码根据错误码(后台给定)判断用户登录是否失效
            [self checkTokenInvalidate:responseObject];
            NSLog(@"url=%@,请求返回结果:%@",url,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"url=%@,请求失败结果:%@",url,error);
            failure(error);
        }
    }];
}


/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [self httpSessionManager:nil responseSerializer:nil];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 本段代码根据错误码(后台给定)判断用户登录是否失效
            [self checkTokenInvalidate:responseObject];
            NSLog(@"url=%@,请求返回结果:%@",url,responseObject);
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"url=%@,请求失败结果:%@",url,error);
            failure(error);
        }
    }];
}

/**
 *  PUT请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)putWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [self httpSessionManager:[AFJSONRequestSerializer serializer] responseSerializer:nil];
    [mgr PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 本段代码根据错误码(后台给定)判断用户登录是否失效
            [self checkTokenInvalidate:responseObject];
            NSLog(@"url=%@,请求返回结果:%@",url,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"url=%@,请求失败结果:%@",url,error);
            failure(error);
        }
    }];
}

/**
 *  请求一张图片
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功block
 *  @param failure 失败block
 */
+ (void)getImageWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [self httpSessionManager:nil responseSerializer:[AFImageResponseSerializer serializer]];
    mgr.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData; //仍进行服务器请求，不直接读缓存
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 本段代码根据错误码(后台给定)判断用户登录是否失效
            [self checkTokenInvalidate:responseObject];
            NSLog(@"url=%@,请求返回结果:%@",url,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"url=%@,请求失败结果:%@",url,error);
            failure(error);
        }
    }];
}

//MARK:- 判断token是否失效
+ (void)checkTokenInvalidate:(id)responseObject {
    
    // 本段代码根据错误码(后台给定)判断用户登录是否失效
    if ([[responseObject objectForKey:@"errCode"] class] != [NSNull class]) {
        NSString *errCode = [responseObject objectForKey:@"errCode"];
        if ([errCode isEqualToString:@"10000"]) { //错误码10000说明token失效
            //请求token过期
            [[NSNotificationCenter defaultCenter]postNotificationName:kTokenInvalidate object:nil];
        }
    }
}


@end


@implementation TTFormData



@end






































