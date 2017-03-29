//
//  TTParamsBase.m
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTParamsBase.h"

@implementation TTParamsBase

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.client = 3;
        self.page = 1;
        self.size = 10;
    }
    return self;
}

@end
