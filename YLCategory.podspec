Pod::Spec.new do |s|

  s.name         = "YLCategory"
  s.version      = "1.0.1"
  s.summary      = "分类"
  s.description  = <<-DESC
                    开发中常用的一些分类
                   DESC
  s.homepage     = "https://github.com/yulong000/YLCategory"
  s.license      = "MIT"
  s.author             = { "weiyulong" => "weiyulong1987@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/yulong000/YLCategory.git", :tag => "1.0.1" }
  s.source_files = "YLCategory/YLCategory/YLCategory/*.{h,m}",
  s.subspec 'LCategory/YLCategory/YLCategory/' do |ss|
  ss.source_files  =    "YLCategory/YLCategory/YLCategory/MBProgressHUD/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/NSDate/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/NSObject/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/NSString/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIAlertController/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIButton/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIColor/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIControl/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIIamge/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UILabel/*.{h,m}",
                        "YLCategory/YLCategory/YLCategory/UIView/*.{h,m}",
                        "YLCategory/YLCategory/MBProgressHUD/*.{h,m}"
end
