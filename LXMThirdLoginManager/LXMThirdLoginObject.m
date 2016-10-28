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

+ (BOOL)isAppInstalled {
    NSAssert(NO, @"need subclass implementation");
    return NO;
}

#pragma mark - network

+ (void)simpleGet:(NSString *)url completedBlock:(void(^)(id response, NSError *error))completedBlcok {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (completedBlcok) {
                completedBlcok(responseObject, connectionError);
            }
        } else {
            if (completedBlcok) {
                completedBlcok(nil, connectionError);
            }
        }
    }];
}

@end
