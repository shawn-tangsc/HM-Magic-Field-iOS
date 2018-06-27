Pod::Spec.new do |s|
s.name         = "HMMagicField"
s.version      = "1.0.0"
s.summary      = "HMMagicField Source ."
s.homepage     = 'https://github.com/shawn-tangsc/HM-Magic-Field-iOS'
s.license      = "MIT"
s.authors      = { "tangsicheng" => "tangscsh@icloud.com" }
s.platform     = :ios
s.ios.deployment_target = "8.0"
s.requires_arc = true
s.source = { :git => 'https://github.com/shawn-tangsc/HM-Magic-Field-iOS.git', :tag => s.version.to_s }
s.source_files = "Source/*.{h,m,mm}"

end
