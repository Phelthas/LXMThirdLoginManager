//
//  LXMThirdLoginObject.m
//  LXMThirdLoginManagerDemo
//
//  Created by luxiaoming on 2016/10/26.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "LXMThirdLoginObject.h"



@implementation LXMThirdLoginResult
@end





@implementation LXMThirdBaseHelper

- (void)setupThirdKey {
    NSAssert(NO, @"need subclass implementation");
}

- (void)requestLogin {
    NSAssert(NO, @"need subclass implementation");
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    NSAssert(NO, @"need subclass implementation");
    return NO;
}

- (BOOL)isAppInstalled {
    NSAssert(NO, @"need subclass implementation");
    return NO;
}

@end
