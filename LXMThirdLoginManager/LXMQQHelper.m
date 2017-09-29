//
//  LXMQQHelper.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "LXMQQHelper.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "LXMThirdLoginManager.h"

@interface LXMQQHelper ()<TencentSessionDelegate, QQApiInterfaceDelegate>

@property (nonatomic, assign) BOOL isLoginWorkflow;//用来区分是登录流程，还是分享流程,这里qqSDK略坑，登录和分享用的不同的类不同的协议，需要调用不同的handleOpenUrl，如果要写到同一个类里面，就需要区分。。。

@end

static TencentOAuth *tencentOAuth;

@implementation LXMQQHelper

- (void)setupThirdKey {
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:[LXMThirdLoginManager sharedManager].kQQAppKey andDelegate:self];
}

- (void)requestLogin {
    self.isLoginWorkflow = YES;
    NSArray *permissions = @[kOPEN_PERMISSION_GET_INFO,
                             kOPEN_PERMISSION_GET_USER_INFO,
                             kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
    [tencentOAuth authorize:permissions inSafari:NO];
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    if (self.isLoginWorkflow == YES) {
        return [TencentOAuth HandleOpenURL:url];
    } else {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }
}

+ (BOOL)isAppInstalled {
    return [TencentOAuth iphoneQQInstalled];
}


#pragma mark - QQApiInterfaceDelegate

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
   
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        LXMThirdShareResult *shareResult = [[LXMThirdShareResult alloc] init];
        shareResult.shareType = LXMThirdLoginTypeQQ;
        shareResult.responseObject = resp;
        if ([LXMThirdLoginManager sharedManager].shareCompletionBlock) {
            [LXMThirdLoginManager sharedManager].shareCompletionBlock(shareResult);
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    
}


#pragma mark - TencentLoginDelegate

- (void)tencentDidLogin {
    [self createThirdLoginResult];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    [self createThirdLoginResult];
}

- (void)tencentDidNotNetWork {
    [self createThirdLoginResult];
}

- (void)getUserInfoResponse:(APIResponse*) response {
    if ([LXMThirdLoginManager sharedManager].shouldRequestUserInfo) {
        if (response.detailRetCode == 0 && response.retCode == 0) {
            LXMThirdLoginResult *loginResult = [[LXMThirdLoginResult alloc] init];
            loginResult.accessToken = tencentOAuth.accessToken;
            loginResult.openId = tencentOAuth.openId;
            loginResult.thirdLoginType = LXMThirdLoginTypeQQ;
            loginResult.expires_in = [tencentOAuth.expirationDate timeIntervalSince1970];
            
            NSDictionary *dict = (NSDictionary *)response.jsonResponse;
            loginResult.userName = dict[@"nickname"];
            loginResult.avatarUrl = dict[@"figureurl_2"];
            if ([dict[@"gender"] isEqualToString:@"男"]) {
                loginResult.gender = 1;
            } else if ([dict[@"gender"] isEqualToString:@"女"]) {
                loginResult.gender = 2;
            }
            
            if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                [LXMThirdLoginManager sharedManager].loginCompletionBlock(loginResult);
            }
            
            
        } else {
            if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                [LXMThirdLoginManager sharedManager].loginCompletionBlock(nil);//错误
            }
        }
        
        
        
        
    }
}

#pragma mark - privateMethod

- (void)createThirdLoginResult {
    self.isLoginWorkflow = NO;
    if (tencentOAuth.accessToken && tencentOAuth.accessToken.length > 0) {
        LXMThirdLoginResult *loginResult = [[LXMThirdLoginResult alloc] init];
        loginResult.accessToken = tencentOAuth.accessToken;
        loginResult.openId = tencentOAuth.openId;
        loginResult.thirdLoginType = LXMThirdLoginTypeQQ;
        loginResult.expires_in = [tencentOAuth.expirationDate timeIntervalSince1970];
        
        if (![LXMThirdLoginManager sharedManager].shouldRequestUserInfo) {
            if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                [LXMThirdLoginManager sharedManager].loginCompletionBlock(loginResult);
            }
        } else {
            //这个获取信息貌似是获取qq空间的信息
            [tencentOAuth getUserInfo];
        }

    } else {
        if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
            [LXMThirdLoginManager sharedManager].loginCompletionBlock(nil);//nil是没有有效数据
        }
    }
}




@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic pop
