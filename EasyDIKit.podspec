Pod::Spec.new do |s|
    s.name = 'EasyDIKit'
    s.version = '1.0.0'
    
    s.summary = 'EasyDIKit is an Objective-C dependency injection framework for iOS.'
    s.homepage = 'https://github.com/mr-noone/easy-di-kit'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.author = { 'Aleksey Zgurskiy' => 'mr.noone@icloud.com' }

    s.platform = :ios, '8.0'

    s.source = { :git => 'https://github.com/mr-noone/easy-di-kit.git', :tag => "#{s.version}" }
    s.source_files = 'EasyDIKit/EasyDIKit/**/*.{h,m}'
    s.prefix_header_file = 'EasyDIKit/EasyDIKit/Support Files/EasyDIKit.pch'
end
