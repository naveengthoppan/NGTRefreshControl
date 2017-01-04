Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "NGTProgressView"
s.summary = "NGTProgressView gives an animating progress view that can be used as subview in refresh cotrol or to any other views to indicate progress."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Naveen George Thoppan" => "naveenjbl@gmail.com" }

# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/naveengthoppan/NGTRefreshControl"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/naveengthoppan/NGTRefreshControl.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"

# 8
s.source_files = "NGTProgressView/**/*.{swift}"

# 9
s.resources = "NGTProgressView/**/*.{png,jpeg,jpg,storyboard,xib}"
end
