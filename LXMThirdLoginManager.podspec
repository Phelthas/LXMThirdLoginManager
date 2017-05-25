#
#  Be sure to run `pod spec lint LXMThirdLoginManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "LXMThirdLoginManager"
  s.version      = "2.0.2"
  s.summary      = "两行代码集成第三方登录."

  s.description  = <<-DESC
		利用cocoaPods完成集成第三方登录的配置，就是添加各种依赖库和linkFlag，使集成第三方登录变成一两句代码的事。
                   DESC

  s.homepage     = "https://github.com/Phelthas/LXMThirdLoginManager"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Phelthas" => "billthas@gmail.com" }
  # Or just: s.author    = "Phelthas"
  # s.authors            = { "Phelthas" => "" }
  # s.social_media_url   = "http://twitter.com/Phelthas"

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/Phelthas/LXMThirdLoginManager.git", :tag => "2.0.2" }

  s.source_files  = "LXMThirdLoginManager", "LXMThirdLoginManager/**/*.{h,m}"
  #  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  s.resources = "LXMThirdLoginManager/**/*.{bundle}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  s.frameworks = "Foundation", "UIKit", "CoreGraphics", "CoreText", "CoreTelephony", "Security", "ImageIO", "QuartzCore", "SystemConfiguration"

  # s.library   = "iconv"
  s.libraries = "stdc++", "sqlite3", "iconv", "c++", "sqlite3.0", "z"
  s.vendored_libraries = "LXMThirdLoginManager/**/*.{a}"
  s.vendored_frameworks = "LXMThirdLoginManager/**/*.{framework}"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

   s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.dependency "WechatOpenSDK", "1.7.7"
  s.dependency "WeiboSDK", "3.1.3"

end
