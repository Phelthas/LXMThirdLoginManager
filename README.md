# LXMThirdLoginManager

LXMThirdLoginManager 是用来一键集成第三方登录的，目前支持新浪微博，微信，和qq登录。       

LXMThirdLoginManager使用cocoapods完成第三方SDK对各种依赖库的配置，封装登录方法和返回结果，并提供是否去调用第三方API去获取userInfo的属性，所以用的时候只需要两行代码就可以完成集成    

目前使用SDK：    
新浪微博SDK V3.1.4  
QQSDK   V3.2.1    
微信SDK V1.7.7

注意：   
1，demo中的工程需要 pod install之后才能运行，     
2，新浪微博SDK要求工程的bundleId与在微博开放平台上注册bundleId一致才可以登录，如果是没有通过审核的应用，只有指定的测试号可以登录    
3，微信现在默认的Appid没有登录权限，请自己找一个可用的appId和appSecret测试     
4，qqSDK要求工程设置一个 bundleDisplayName

[这里](http://www.cnblogs.com/Phelthas/p/4505108.html)有一篇总结。

## Install  
1,在没有使用 `use_framework!`命令的项目中使用
  在Podfile中加入 `pod 'LXMThirdLoginManager', ~> '2.2.0'`, 然后 `pod update`或 `pod install`    
2, 在使用了`use_framework!`命令的项目中使用（Swift项目）    
  手动下载2.2.0版本以上代码，将LXMThirdLoginManager文件夹下全部内容拖到项目中，然后在Podfile中加入 `pod 'LXMThirdLoginManager/SwiftSetting', ~> '2.2.0'`, 最后 `pod update`或 `pod install`    

## How to use
1，在appDelegate的 didLaunch方法中调用    

     [[LXMThirdLoginManager sharedManager] setupWithSinaWeiboAppKey:kSinaWeiboAppKey SinaWeiboRedirectURI:kSinaWeiboRedirectURI WeChatAppKey:kWeChatAppKey WeChatAppSecret:kWeChatAppSecret QQAppKey:kQQAppKey];      
    
2，重写`- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation `方法，在其中加入      

     return [[LXMThirdLoginManager sharedManager] handleOpenUrl:url];

3，在工程的info处，设置URLTypes 为你在第三方平台所注册的appId   

4，在需要登录的地方，调用       

      - (void)requestLoginWithThirdType:(LXMThirdLoginType)thirdLoginType completeBlock:(LXMThirdLoginCompleteBlock)completeBlock;    
    
        
    
## Update 
2.2.0  将库分为Core和SwiftSetting两个subspec，Core用法和原来完全一样；SwiftSetting用来解决Swift工程使用的问题    
2.1.0  更新SDK文件QQ改用3.2.1;微信改用1.7.7    
2.0.1，删除qqSDK资源文件里面的info.plist文件，解决上传appstore失败的问题    
2.0.0，更新API命名，更新代码结构和实现方式，加入分享结果的回调

## Help
如果有什么问题，欢迎issue和pullRequest  

## License
LXMKeyboardManager is available under the MIT license. See the LICENSE file for more info. 

