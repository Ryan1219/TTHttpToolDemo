//
//  TTParamsBase.h
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//
// 请求参数基类
#import <Foundation/Foundation.h>

@interface TTParamsBase : NSObject
@property (nonatomic,assign) int client; //客户端: 1 TOMTOP-PC,2 TOMTOP-Mobile,3 TOMTOP-APP-IOS,4 TOMTOP-APP-Android
@property (nonatomic,assign) int page;//页数 默认为1
@property (nonatomic,assign) int size;//大小 默认为10


@end
