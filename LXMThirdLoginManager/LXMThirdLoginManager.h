//
//  LXMThirdLoginManager.h
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXMThirdLoginObject.h"
#import "LXMThirdShareObject.h"

/*
 当前SDK版本：
 微博3.2.3
 微信1.8.0包含支付功能版
 QQ3.3.0lite版
 */

@interface LXMThirdLoginManager : NSObject

@property (nonatomic, copy, readonly) NSString *kSinaWeiboAppKey;
@property (nonatomic, copy, readonly) NSString *kSinaWeiboRedirectURI;
@property (nonatomic, copy, readonly) NSString *kWeChatAppKey;
@property (nonatomic, copy, readonly) NSString *kWeChatAppSecret;
@property (nonatomic, copy, readonly) NSString *kQQAppKey;

/**
 *  是否在获取到openID和accessToken之后调用其他接口获取userInfo，default is YES;
 */
@property (nonatomic, assign) BOOL shouldRequestUserInfo;

/**
 测试的时候新浪微博可能会出现BundleId对不上的问题，可以设置这个字段来解决，内部会用methodSwizzling的方式替换；
 必须在setupWithSinaWeiboAppKey之前设置！！！
 */
@property (nonatomic, copy) NSString *appBundleId;


@property (nonatomic, copy, readonly) LXMThirdLoginCompletionBlock loginCompletionBlock;


@property (nonatomic, copy) LXMThirdShareCompletionBlock shareCompletionBlock;


+ (instancetype)sharedManager;

+ (BOOL)isAppInstalledForLoginType:(LXMThirdLoginType)type;

- (void)setupWithSinaWeiboAppKey:(NSString *)sinaWeiboAppKey sinaWeiboRedirectURI:(NSString *)sinaWeiboRedirectURI weChatAppKey:(NSString *)weChatAppKey weChatAppSecret:(NSString *)weChatAppSecret QQAppKey:(NSString *)qqAppKey;


- (void)requestLoginWithThirdType:(LXMThirdLoginType)thirdLoginType completeBlock:(LXMThirdLoginCompletionBlock)completeBlock;


- (BOOL)handleOpenUrl:(NSURL *)url;



@end
