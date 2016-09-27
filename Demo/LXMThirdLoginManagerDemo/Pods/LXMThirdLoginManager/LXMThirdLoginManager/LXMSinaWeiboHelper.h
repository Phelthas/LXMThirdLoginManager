//
//  LXMSinaWeiboHelper.h
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/11.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXMSinaWeiboHelper : NSObject

+ (void)setupThirdLogin;

+ (void)requestLogin;

+ (BOOL)handleOpenUrl:(NSURL *)url;


@end
