#
#  Be sure to run `pod spec lint LXMThirdLoginManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LXMThirdLoginManager"
  s.version      = "2.4.0"
  s.summary      = "两行代码集成第三方登录."
  s.description  = <<-DESC
		利用cocoaPods完成集成第三方登录的配置，就是添加各种依赖库和linkFlag，使集成第三方登录变成一两句代码的事。
                   DESC
  s.homepage     = "https://github.com/Phelthas/LXMThirdLoginManager"
  s.license      = "MIT"
  s.author             = { "Phelthas" => "billthas@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Phelthas/LXMThirdLoginManager.git", :tag => "2.4.0" }
  #  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.resources = "LXMThirdLoginManager/**/*.{bundle}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"



   s.requires_arc = true


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
#  s.dependency "WechatOpenSDK", "1.7.7"
#  s.dependency "WeiboSDK", "3.1.3"


    s.default_subspec = 'Core'

    s.subspec 'Core' do |core|
        core.source_files = "LXMThirdLoginManager", "LXMThirdLoginManager/**/*.{h,m}"
        core.frameworks = "Photos", "Foundation", "UIKit", "CoreGraphics", "CoreText", "CoreTelephony", "Security", "ImageIO", "QuartzCore", "SystemConfiguration"
        core.libraries = "stdc++", "sqlite3", "iconv", "c++", "sqlite3.0", "z"
        core.vendored_libraries = "LXMThirdLoginManager/**/*.{a}"
        core.vendored_frameworks = "LXMThirdLoginManager/**/*.{framework}"
    end

    s.subspec 'SwiftSetting' do |setting|
        setting.source_files = "ReadMe/*.{h,m}"
        setting.frameworks = "Photos", "Foundation", "UIKit", "CoreGraphics", "CoreText", "CoreTelephony", "Security", "ImageIO", "QuartzCore", "SystemConfiguration"
        setting.libraries = "stdc++", "sqlite3", "iconv", "c++", "sqlite3.0", "z"
        setting.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-l"stdc++" -l"sqlite3" -l"iconv" -l"c++" -l"sqlite3.0" -l"z" -framework "CoreGraphics" -framework "CoreText" -framework "CoreTelephony" -framework "Security" -framework "ImageIO" -framework "QuartzCore" -framework "SystemConfiguration" -framework "Photos" ' }

    end

end
