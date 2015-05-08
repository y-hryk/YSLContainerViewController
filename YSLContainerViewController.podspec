@version = "0.0.1"
Pod::Spec.new do |s|
  s.name         = "YSLContainerViewController"
  s.version      = @version
  s.summary      = "google auto completion"
  s.homepage     = "https://github.com/y-hryk/YSLContainerViewController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "y-hryk" => "dev.hy630823@gmail.com" }
  s.source       = { :git => "https://github.com/y-hryk/YSLContainerViewController.git", :tag => @version }
  s.source_files = 'YSLContainerViewController/**/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end