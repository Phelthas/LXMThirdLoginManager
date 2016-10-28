//
//  LXMWeChatHelper.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "LXMWeChatHelper.h"
#import "WXApi.h"
#import "LXMThirdLoginManager.h"



@interface LXMWeChatHelper ()<WXApiDelegate>

@end

@implementation LXMWeChatHelper

- (void)setupThirdKey {
    [WXApi registerApp:[LXMThirdLoginManager sharedManager].kWeChatAppKey];
}

- (void)requestLogin {
    SendAuthReq *request = [[SendAuthReq alloc] init];
    request.scope = @"snsapi_userinfo";
    request.state = @"123";
    
    [WXApi sendReq:request];
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];

}

+ (BOOL)isAppInstalled {
    return [WXApi isWXAppInstalled];
}


#pragma mark - WXApi

- (void)requestTokenWithCode:(NSString *)code completedBlock:(LXMThirdLoginCompletionBlock)completionBlock {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", [LXMThirdLoginManager sharedManager].kWeChatAppKey, [LXMThirdLoginManager sharedManager].kWeChatAppSecret, code];
    [LXMThirdBaseHelper simpleGet:url completedBlock:^(id response, NSError *error) {
        if (error == nil && response && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)response;
            LXMThirdLoginResult *result = [[LXMThirdLoginResult alloc] init];
            result.thirdLoginType = LXMThirdLoginTypeWeChat;
            result.accessToken = dict[@"access_token"];
            result.openId = dict[@"openid"];
            result.refresh_token = dict[@"refresh_token"];
            result.expires_in = [dict[@"expires_in"] doubleValue];
            
            result.errorCode = [dict[@"errcode"] integerValue];//错误时才有
            result.message = dict[@"errmsg"];//错误时才有
            
            if (completionBlock) {
                completionBlock(result);
            }
            
        } else {
            if (completionBlock) {
                completionBlock(nil);//不管有什么错误，都返回nil，表示获取信息失败
            }
        }
        
    }];
}

- (void)requestUserInfoWith:(LXMThirdLoginResult *)tempResult completedBlock:(LXMThirdLoginCompletionBlock)completedBlock {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",tempResult.accessToken, tempResult.openId];
    [LXMThirdBaseHelper simpleGet:url completedBlock:^(id response, NSError *error) {
        if (error == nil && response && [response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)response;
            tempResult.userName = dict[@"nickname"];
            tempResult.avatarUrl = dict[@"headimgurl"];
            tempResult.gender = [dict[@"sex"] integerValue];
            tempResult.unionid = dict[@"unionid"];
            
            tempResult.errorCode = [dict[@"errcode"] integerValue];//错误时才有
            tempResult.message = dict[@"errmsg"];//错误时才有
            if (completedBlock) {
                completedBlock(tempResult);
            }
            
        } else {
            if (completedBlock) {
                completedBlock(nil);
            }
        }
        
    }];
}


#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq*)req {
    
}


- (void)onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *tempResp = (SendAuthResp *)resp;
        if (resp.errCode == 0) {
            [self requestTokenWithCode:tempResp.code completedBlock:^(LXMThirdLoginResult *thirdLoginResult) {
                if (![LXMThirdLoginManager sharedManager].shouldRequestUserInfo) {
                    //如果不用个人信息，那这时候返回的有效信息只有一个accessToken
                    if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                        [LXMThirdLoginManager sharedManager].loginCompletionBlock(thirdLoginResult);
                    }
                } else {
                    [self requestUserInfoWith:thirdLoginResult completedBlock:^(LXMThirdLoginResult *thirdLoginResult) {
                        if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                            [LXMThirdLoginManager sharedManager].loginCompletionBlock(thirdLoginResult);
                        }
                        
                    }];
                }
            }];
            
        } else {
            if ([LXMThirdLoginManager sharedManager].loginCompletionBlock) {
                [LXMThirdLoginManager sharedManager].loginCompletionBlock(nil);//nil说明是微博没有返回正确的数据
            }
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        LXMThirdShareResult *shareResult = [[LXMThirdShareResult alloc] init];
        shareResult.shareType = LXMThirdLoginTypeWeChat;
        shareResult.responseObject = resp;
        if ([LXMThirdLoginManager sharedManager].shareCompletionBlock) {
            [LXMThirdLoginManager sharedManager].shareCompletionBlock(shareResult);
        }
    }

}

@end
