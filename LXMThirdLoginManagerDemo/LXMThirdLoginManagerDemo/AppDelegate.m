//
//  AppDelegate.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/14.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "AppDelegate.h"
#import <LXMThirdLoginManager.h>

static NSString * const kSinaWeiboAppKey = @"2853075952"; //自己注册的,对应的bundleID必须是 TEST-weibo（在info.plist中修改），因为还没提交审核，所以只有我自己的账号才能登陆成功
static NSString * const kSinaWeiboRedirectURI = @"http://www.baidu.com";
static NSString * const kWeChatAppKey = nil;
static NSString * const kWeChatAppSecret = nil;
static NSString * const kQQAppKey = nil;


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[LXMThirdLoginManager sharedManager] setupWithSinaWeiboAppKey:kSinaWeiboAppKey sinaWeiboRedirectURI:kSinaWeiboRedirectURI weChatAppKey:kWeChatAppKey weChatAppSecret:kWeChatAppSecret QQAppKey:kQQAppKey];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[LXMThirdLoginManager sharedManager] handleOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[LXMThirdLoginManager sharedManager] handleOpenUrl:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
