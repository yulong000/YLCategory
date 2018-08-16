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
  s.source_files  = "YLCategory", "YLCategory/YLCategory/YLCategory/**/*", "YLCategory/YLCategory/MBProgressHUD/*.{h,m}"
end
