//
//  ViewController.m
//  TTAFNetworkingDemo
//
//  Created by zhang liangwang on 17/3/22.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"
#import "TTUserCenterNetworkTool.h"
#import "TTResultBase.h"
#import "TTParamsBase.h"
#import "AFNetworkReachabilityManager.h"
#import "Reachability.h"


@interface ViewController ()

@property (nonatomic,strong) Reachability *reachability;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
   
}

//MARK:-AFNetworking 网络状态监听
/*
typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1, //未知网络
    AFNetworkReachabilityStatusNotReachable     = 0,  //无法识别的网络
    AFNetworkReachabilityStatusReachableViaWWAN = 1,  //手机网络
    AFNetworkReachabilityStatusReachableViaWiFi = 2,  //WiFi网络
};
*/
- (void)checkNetworkStatusWithAFNetworking {
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"-----status--%zd",status);
    }];
    
    [mgr startMonitoring];
    
    /**
     The current network reachability status.
     */
    //    @property (readonly, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
    //mgr.networkReachabilityStatus //获取当前网络状态
}



//MARK:-苹果自带网络监听
- (void)checkNetworkStatusWithIphone {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatus) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}

/*
typedef NS_ENUM(NSInteger, NetworkStatus) {
    // Apple NetworkStatus Compatible Names.
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};
*/
- (void)networkStatus {
    
    if ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus != NotReachable) {
        NSLog(@"wifi");
    } else if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable) {
        NSLog(@"手机网络");
    } else {
        NSLog(@"无法识别的网络");
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//MARK:-接口请求
- (void)getPersonInfo {
    
    // 例子
    TTParamsBase *params = [[TTParamsBase alloc] init];
    
    [TTUserCenterNetworkTool getUserInfo:params success:^(TTResultBase *result) {
        
        if (result.ret == 1) {
            
            
        } else {
            
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
