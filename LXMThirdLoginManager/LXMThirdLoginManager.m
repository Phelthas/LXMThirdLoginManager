//
//  LXMThirdLoginManager.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "LXMThirdLoginManager.h"
#import "LXMSinaWeiboHelper.h"
#import "LXMWeChatHelper.h"
#import "LXMQQHelper.h"


@interface LXMThirdLoginManager ()

@property (nonatomic, copy, readwrite) LXMThirdLoginCompletionBlock loginCompletionBlock;

@property (nonatomic, copy, readwrite) NSString *kSinaWeiboAppKey;
@property (nonatomic, copy, readwrite) NSString *kSinaWeiboRedirectURI;
@property (nonatomic, copy, readwrite) NSString *kWeChatAppKey;
@property (nonatomic, copy, readwrite) NSString *kWeChatAppSecret;
@property (nonatomic, copy, readwrite) NSString *kQQAppKey;


@property (nonatomic, strong) LXMSinaWeiboHelper *sinaWeiboHelper;
@property (nonatomic, strong) LXMWeChatHelper *weChatHelper;
@property (nonatomic, strong) LXMQQHelper *qqHelper;



@end

@implementation LXMThirdLoginManager

+ (instancetype)sharedManager {
    static LXMThirdLoginManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldRequestUserInfo = YES;
    }
    return self;
    
}

- (void)setupWithSinaWeiboAppKey:(NSString *)sinaWeiboAppKey sinaWeiboRedirectURI:(NSString *)sinaWeiboRedirectURI weChatAppKey:(NSString *)weChatAppKey weChatAppSecret:(NSString *)weChatAppSecret QQAppKey:(NSString *)qqAppKey {
    if (sinaWeiboAppKey && sinaWeiboRedirectURI) {
        self.kSinaWeiboAppKey = sinaWeiboAppKey;
        self.kSinaWeiboRedirectURI = sinaWeiboRedirectURI;
        [self.sinaWeiboHelper setupThirdKey];
    }
    if (weChatAppKey && weChatAppSecret) {
        self.kWeChatAppKey = weChatAppKey;
        self.kWeChatAppSecret = weChatAppSecret;
        [self.weChatHelper setupThirdKey];
    }
    if (qqAppKey) {
        self.kQQAppKey = qqAppKey;
        [self.qqHelper setupThirdKey];
    }
}

- (void)requestLoginWithThirdType:(LXMThirdLoginType)thirdLoginType completeBlock:(LXMThirdLoginCompletionBlock)completeBlock {
    self.loginCompletionBlock = completeBlock;
    switch (thirdLoginType) {
        case LXMThirdLoginTypeSinaWeibo:
            [self.sinaWeiboHelper requestLogin];
            break;
        case LXMThirdLoginTypeWeChat:
            [self.weChatHelper requestLogin];
            break;
        case LXMThirdLoginTypeQQ:
            [self.qqHelper requestLogin];
            break;
        default:
            break;
    }
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    if (url) {
        if (self.kSinaWeiboAppKey && [url.scheme hasSuffix:self.kSinaWeiboAppKey]) {
            return [self.sinaWeiboHelper handleOpenUrl:url];
        } else if (self.kWeChatAppKey && [url.scheme hasSuffix:self.kWeChatAppKey]) {
            return [self.weChatHelper handleOpenUrl:url];
        } else if (self.kQQAppKey && [url.scheme hasSuffix:self.kQQAppKey]) {
            return [self.qqHelper handleOpenUrl:url];
        }
    }
    return NO;
}

#pragma mark - 检查是否安装

+ (BOOL)isAppInstalledForLoginType:(LXMThirdLoginType)type {
    switch (type) {
        case LXMThirdLoginTypeSinaWeibo:
            return [LXMSinaWeiboHelper isAppInstalled];
            break;
        case LXMThirdLoginTypeWeChat:
            return [LXMWeChatHelper isAppInstalled];
            break;
        case LXMThirdLoginTypeQQ:
            return [LXMQQHelper isAppInstalled];
            break;
        default:
            return NO;
            break;
    }
}



#pragma mark - Property

- (LXMSinaWeiboHelper *)sinaWeiboHelper {
    if (!_sinaWeiboHelper) {
        _sinaWeiboHelper = [[LXMSinaWeiboHelper alloc] init];
    }
    return _sinaWeiboHelper;
}

- (LXMWeChatHelper *)weChatHelper {
    if (!_weChatHelper) {
        _weChatHelper = [[LXMWeChatHelper alloc] init];
    }
    return _weChatHelper;
}

- (LXMQQHelper *)qqHelper {
    if (!_qqHelper) {
        _qqHelper = [[LXMQQHelper alloc] init];
    }
    return _qqHelper;
}

@end
