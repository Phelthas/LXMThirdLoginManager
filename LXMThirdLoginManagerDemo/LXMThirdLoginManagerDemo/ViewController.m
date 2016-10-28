//
//  ViewController.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/14.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "ViewController.h"
#import <LXMThirdLoginManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - buttonAction

- (IBAction)handleWeiboButtonTapped:(UIButton *)sender {
    if (![LXMThirdLoginManager isAppInstalledForLoginType:LXMThirdLoginTypeSinaWeibo]) {
        return; //一般来说这个是用来判断这个第三方登录的按钮是否应该显示出来的
    }
    
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeSinaWeibo completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.errorCode == 0) {
            NSLog(@"thirdLoginResult is %@ \n name:%@ \n avatar:%@", thirdLoginResult, thirdLoginResult.userName, thirdLoginResult.avatarUrl);
            
        } else {
            NSLog(@"error_code: %@, error_message: %@", @(thirdLoginResult.errorCode), thirdLoginResult.message);
        }
    }];
}

- (IBAction)handleWeiXinButtonTapped:(id)sender {
    if (![LXMThirdLoginManager isAppInstalledForLoginType:LXMThirdLoginTypeWeChat]) {
        //一般来说这个是用来判断这个第三方登录的按钮是否应该显示出来的
        return;
    }
    
    [LXMThirdLoginManager sharedManager].shouldRequestUserInfo = YES;
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeWeChat completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.errorCode == 0) {
            NSLog(@"thirdLoginResult is %@ \n name:%@ \n avatar:%@", thirdLoginResult, thirdLoginResult.userName, thirdLoginResult.avatarUrl);
        } else {
            NSLog(@"error_code: %@, error_message: %@", @(thirdLoginResult.errorCode), thirdLoginResult.message);
        }
    }];
}

- (IBAction)handleQQButtonTapped:(id)sender {
    if (![LXMThirdLoginManager isAppInstalledForLoginType:LXMThirdLoginTypeQQ]) {
        //一般来说这个是用来判断这个第三方登录的按钮是否应该显示出来的
        return;
    }
    
    [LXMThirdLoginManager sharedManager].shouldRequestUserInfo = YES;
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeQQ completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.errorCode == 0) {
            NSLog(@"thirdLoginResult is %@ \n name:%@ \n avatar:%@", thirdLoginResult, thirdLoginResult.userName, thirdLoginResult.avatarUrl);
            
        } else {
            NSLog(@"error_code: %@, error_message: %@", @(thirdLoginResult.errorCode), thirdLoginResult.message);
        }
    }];
}

@end
