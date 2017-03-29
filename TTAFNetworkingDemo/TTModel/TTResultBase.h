//
//  TTResultBase.h
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//
// 返回结果基类
#import <Foundation/Foundation.h>

@interface TTResultBase : NSObject

@property (nonatomic, assign) double ret; //接口返回状态
@property (nonatomic, strong) NSString *errCode; //错误码
@property (nonatomic, strong) NSString *errMsg; //错误信息

@end
