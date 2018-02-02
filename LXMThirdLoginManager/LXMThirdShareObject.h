//
//  LXMThirdShareObject.h
//  Pods
//
//  Created by luxiaoming on 2016/10/27.
//
//

#import <Foundation/Foundation.h>
#import "LXMThirdLoginObject.h"

//typedef NS_ENUM(NSInteger, LXMThirdShareType) {
//    LXMThirdShareTypeSinaWeibo = 0,//新浪微博
//    LXMThirdShareTypeWXSceneSession = 1,//微信聊天页面
//    LXMThirdShareTypeWXSceneTimeline = 2,
//    LXMThirdShareTypeWXSceneFavorite = 3,
//    
//};

@class LXMThirdShareResult;
typedef void(^LXMThirdShareCompletionBlock)(LXMThirdShareResult * _Nullable shareResult);






@interface LXMThirdShareResult : NSObject

@property (nonatomic, assign) BOOL success;//统一以后的分享记过，yes为成功，其他为失败
@property (nonatomic, copy, nullable) NSString *message;//统一以后的错误提示信息，失败时存在，失败时也可能为nil
@property (nonatomic, assign) LXMThirdLoginType shareType;//这里貌似区分不出来是朋友圈还是会话，所以暂时用app来区分

/**
 第三方分享返回的结果，可能是SendMessageToWXResp，SendMessageToQQResp，WBSendMessageToWeiboResponse
 */
@property (nonatomic, strong, nullable) id responseObject;

@end




