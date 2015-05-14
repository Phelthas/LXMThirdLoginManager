//
//  ViewController.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 15/5/14.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "ViewController.h"
#import <LXMThirdLoginManager.h>
#import <LXMThirdLoginResult.h>

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
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeSinaWeibo completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.thirdLoginState == 0) {
            NSLog(@"thirdLoginResult is %@", thirdLoginResult);
            
        } else {
            
        }
    }];
}

- (IBAction)handleWeiXinButtonTapped:(id)sender {
    [LXMThirdLoginManager sharedManager].shouldRequestUserInfo = YES;
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeWeChat completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.thirdLoginState == 0) {
            NSLog(@"thirdLoginResult is %@", thirdLoginResult);
            
        } else {
            
        }
    }];
}

- (IBAction)handleQQButtonTapped:(id)sender {
    [LXMThirdLoginManager sharedManager].shouldRequestUserInfo = YES;
    [[LXMThirdLoginManager sharedManager] requestLoginWithThirdType:LXMThirdLoginTypeQQ completeBlock:^(LXMThirdLoginResult *thirdLoginResult) {
        if (thirdLoginResult && thirdLoginResult.thirdLoginState == 0) {
            NSLog(@"thirdLoginResult is %@", thirdLoginResult);
            
        } else {
            
        }
    }];
}

@end
