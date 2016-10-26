//
//  LXMThirdLoginManager.h
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXMThirdLoginObject.h"

/*
 当前SDK版本：
 微博3.1.4
 微信1.7.3
 QQ2.9.0
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


@property (nonatomic, copy, readonly) LXMThirdLoginCompletionBlock loginCompletionBlcok;


+ (instancetype)sharedManager;

+ (BOOL)isAppInstalledForLoginType:(LXMThirdLoginType)type;

- (void)setupWithSinaWeiboAppKey:(NSString *)sinaWeiboAppKey sinaWeiboRedirectURI:(NSString *)sinaWeiboRedirectURI weChatAppKey:(NSString *)weChatAppKey weChatAppSecret:(NSString *)weChatAppSecret QQAppKey:(NSString *)qqAppKey;


- (void)requestLoginWithThirdType:(LXMThirdLoginType)thirdLoginType completeBlock:(LXMThirdLoginCompletionBlock)completeBlock;


- (BOOL)handleOpenUrl:(NSURL *)url;

/**
 *  简单的网络请求方法，调用第三方api可能会用到
 */
+ (void)simpleGet:(NSString *)url completedBlock:(void(^)(id response, NSError *error))completedBlcok;

@end
