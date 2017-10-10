//
//  LXMThirdLoginManagerReadMe.h
//  Pods
//
//  Created by luxiaoming on 2017/6/13.
//
//

#import <Foundation/Foundation.h>

/**
 在swift项目中（在Podfile中使用了use_framework!），直接使用cocoapods安装本库会导致项目编译或运行的时候出错，
 失败的原因主要是就是“use_framework!”这个命令；
 这个命令会让pods中所有的库都以framework的方式来编译，而第三方登录SDK本来包含静态库文件（.a文件），里面可能有不对外暴露的字符串什么的，
 微博SDK问题参见https://github.com/sinaweibosdk/weibo_ios_sdk/issues/284
 和https://github.com/sinaweibosdk/weibo_ios_sdk/issues/192
 qqSDK编译的时候没问题，但一旦使用QQAipservice的方法，就会报错crash，应该也是类似的问题~
 微信SDK貌似没什么问题~
 
 针对以上问题，我最终找到的解决方案就是这个SwiftSetting这个分支！
 其实里面没有任何代码，配置操作还是在podspec文件中完成，你需要做的是：
 1，将这个库手动下载下来，将LXMThirdLoginManager文件夹直接拖到自己项目工程中（记得勾选 copy items）
 2，在你的podfile中加入 `LXMThirdLoginManager/SwiftSetting` 然后 pod install
 
 原理：
 cocoapods安装第三方库导致失败，那我手动把这些第三方库拖进工程里不就行了嘛！
 本来这个库最最大的作用也是帮助省去依赖库设置的麻烦，统一调用接口而已；
 拖进去代码就可以用，只需要在桥接头文件中加入`#import "LXMThirdLoginManager.h"`一句而已
 问题是怎么省去设置依赖库的麻烦，这个还是得依靠cocoapods：
 用s.frameworks 和 s.libraries 等参数设置，
 这里关键是setting.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-l"stdc++" -l"sqlite3" -l"iconv" -l"c++" -l"sqlite3.0" -l"z" -framework "CoreGraphics" -framework "CoreText" -framework "CoreTelephony" -framework "Security" -framework "ImageIO" -framework "QuartzCore" -framework "SystemConfiguration" -framework "Photos" ' }这一句
 user_target_xcconfig参数的意思是，这个config生效的范围是用户的整个target，而不仅仅是pod的target
 具体见https://guides.cocoapods.org/syntax/podspec.html#user_target_xcconfig
 官方文档的说法是这个参数可能会污染项目工程或者可能会导致冲突，所以不推荐使用，
 但目前我还没有其他更好的方式，所以只能先这么将就了
 
 */
@interface LXMThirdLoginManagerReadMe : NSObject

@end
