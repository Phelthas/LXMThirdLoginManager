//
//  LXMThirdLoginObject.h
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 2016/10/26.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LXMThirdLoginType) {
    LXMThirdLoginTypeSinaWeibo = 0,
    LXMThirdLoginTypeWeChat = 1,
    LXMThirdLoginTypeQQ = 2,
};




@class LXMThirdLoginResult;
typedef void(^LXMThirdLoginCompletionBlock)(LXMThirdLoginResult * _Nullable thirdInfo);



@interface LXMThirdLoginResult : NSObject

@property (nonatomic, assign) NSInteger errorCode;//0成功，其他失败
@property (nonatomic, copy, nullable) NSString *message;//失败时才有

@property (nonatomic, assign) LXMThirdLoginType thirdLoginType;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy, nullable) NSString *unionid; //微信特有
@property (nonatomic, assign) NSTimeInterval expires_in;
@property (nonatomic, copy, nullable) NSString *refresh_token;


@property (nonatomic, copy, nullable) NSString *userName;
@property (nonatomic, assign) NSInteger gender;//0未知，1男，2女，这是统一后的结果
@property (nonatomic, copy, nullable) NSString *signature;
@property (nonatomic, assign) NSTimeInterval *birthday;
@property (nonatomic, copy, nullable) NSString *avatarUrl;

@end



@interface LXMThirdBaseHelper : NSObject

- (void)setupThirdKey;

- (void)requestLogin;

- (BOOL)handleOpenUrl:(nullable NSURL *)url;

+ (BOOL)isAppInstalled;


/**
 *  简单的网络请求方法，调用第三方api可能会用到
 */
+ (void)simpleGet:(NSString *)url completedBlock:(nullable void(^)(id _Nullable response, NSError * _Nullable error))completedBlcok;

@end

NS_ASSUME_NONNULL_END


