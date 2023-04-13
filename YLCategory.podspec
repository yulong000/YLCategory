Pod::Spec.new do |s|

s.name                  = 'YLCategory'
s.version               = '1.2.4'
s.summary               = '分类'
s.homepage              = 'https://github.com/yulong000/YLCategory'
s.license               = { :type => 'MIT', :file => 'LICENSE'}
s.author                = { 'weiyulong' => 'weiyulong1987@163.com' }
s.platform              = :ios, '11.0'
s.source                = { :git => 'https://github.com/yulong000/YLCategory.git', :tag => s.version}
s.source_files          = 'YLCategory/YLCategory.h'
s.requires_arc          = true

s.subspec 'Others' do |ss|
    ss.source_files     = 'YLCategory/Others/*.{h,m}'
end

s.subspec 'UIView' do |ss|
    ss.source_files     = 'YLCategory/UIView/*.{h,m}'
end

s.subspec 'UIImage' do |ss|
    ss.source_files     = 'YLCategory/UIImage/*.{h,m}'
end

s.subspec 'UIButton' do |ss|
    ss.source_files     = 'YLCategory/UIButton/*.{h,m}'
end

s.subspec 'UISwitch' do |ss|
    ss.source_files     = 'YLCategory/UISwitch/*.{h,m}'
end

s.subspec 'UIAlertController' do |ss|
    ss.source_files     = 'YLCategory/UIAlertController/*.{h,m}'
    ss.dependency         'YLCategory/Others'
end

s.subspec 'UIColor' do |ss|
    ss.source_files     = 'YLCategory/UIColor/*.{h,m}'
end

s.subspec 'NSString' do |ss|
    ss.source_files     = 'YLCategory/NSString/*.{h,m}'
end

s.subspec 'UILabel' do |ss|
    ss.source_files     = 'YLCategory/UILabel/*.{h,m}'
end

s.subspec 'MBProgressHUD' do |ss|
    ss.source_files     = 'YLCategory/MBProgressHUD/*.{h,m}'
    ss.resource         = 'YLCategory/MBProgressHUD/MBProgressHUD.bundle'
end

s.subspec 'UIControl' do |ss|
    ss.source_files     = 'YLCategory/UIControl/*.{h,m}'
end

s.subspec 'NSDate' do |ss|
    ss.source_files     = 'YLCategory/NSDate/*.{h,m}'
end

s.subspec 'NSObject' do |ss|
    ss.source_files     = 'YLCategory/NSObject/*.{h,m}'
end

s.subspec 'UIViewController' do |ss|
    ss.source_files     = 'YLCategory/UIViewController/*.{h,m}'
    ss.dependency         'YLCategory/UIAlertController'
end

end


# 升级时  1.add tag
#        2.push tag
#        3.pod trunk push YLCategory.podspec --allow-warnings

