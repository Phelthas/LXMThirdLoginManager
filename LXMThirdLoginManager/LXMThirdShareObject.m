//
//  LXMThirdShareObject.m
//  Pods
//
//  Created by luxiaoming on 2016/10/27.
//
//

#import "LXMThirdShareObject.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"


@implementation LXMThirdShareResult


- (BOOL)success {
    if ([self.responseObject isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *resp = (SendMessageToWXResp *)self.responseObject;
        if (resp.errCode == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    else if ([self.responseObject isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp *resp = (SendMessageToQQResp *)self.responseObject;
        if (resp.result.integerValue == EQQAPISENDSUCESS) {
            return YES;
        } else {
            return NO;
        }
    }
    else if ([self.responseObject isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        WBSendMessageToWeiboResponse *resp = (WBSendMessageToWeiboResponse *)self.responseObject;
        if (resp.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            return YES;
        } else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

- (NSString *)message {
    if ([self.responseObject isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *resp = (SendMessageToWXResp *)self.responseObject;
        if (resp.errCode == 0) {
            return nil;
        } else {
            return resp.errStr;
        }
    }
    else if ([self.responseObject isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp *resp = (SendMessageToQQResp *)self.responseObject;
        if (resp.result.integerValue == EQQAPISENDSUCESS) {
            return nil;
        } else {
            return resp.errorDescription;
        }
    }
    else if ([self.responseObject isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        WBSendMessageToWeiboResponse *resp = (WBSendMessageToWeiboResponse *)self.responseObject;
        if (resp.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            return nil;
        } else {
            return nil;
        }
    }
    else {
        return nil;
    }
}

@end
