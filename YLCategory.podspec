Pod::Spec.new do |s|

s.name         = 'YLCategory'
s.version      = '1.2.4'
s.summary      = '分类'
s.homepage     = 'https://github.com/yulong000/YLCategory'
s.license      = 'MIT'
s.author       = { 'weiyulong' => 'weiyulong1987@163.com' }
s.platform     = :ios, '11.0'
s.source       = { :git => 'https://github.com/yulong000/YLCategory.git', :tag => s.version}
s.source_files = 'YLCategory/YLCategory.h'
s.public_header_files = 'YLCategory/YLCategory.h'
s.requires_arc = true

end


# 升级时  1.add tag
#        2.push tag
#        3.pod trunk push YLCategory.podspec --allow-warnings

