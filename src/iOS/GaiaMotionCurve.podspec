Pod::Spec.new do |s|

  s.name         = "GaiaMotionCurve"
  s.version      = "0.1.0"
  s.summary      = "a library to solve the problems of high cost of developing dynamic effects and inconsistent effects and design expectations"
  s.license      = { :type => 'Apache License, Version 2.0' }
  s.homepage     = "https://github.com/alibaba/gaia-motion-curve"

  s.author             = { "ronghui.zrh" => "ronghui.zrh@alibaba-inc.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/alibaba/gaia-motion-curve.git", :tag => s.version }


  s.source_files = 'src/iOS/GaiaMotionCurve/**/*.{h,m,mm,c}'
  s.xcconfig = { "ENABLE_BITCODE" => "NO" }
  s.requires_arc = true
end
