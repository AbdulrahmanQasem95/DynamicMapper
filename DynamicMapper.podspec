#
# Be sure to run `pod lib lint DynamicMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DynamicMapper'
    s.version          = '2.0.1'
    s.license          = 'MIT'
    s.summary          = 'Map your model dynamically using native Codable'
    
    s.description      = <<-DESC
    'DynamicMapper is a framework written in Swift for dynamically decoding and encoding models (reference and value types) using Swift native Decodable and Encodable protocols. Nested Objects encoding and decoding (Dynamic Mapping), Dynamic object insertion and creation and smooth transformation from Codable'
    DESC
    s.homepage         = 'https://github.com/AbdulrahmanQasem95/DynamicMapper'
    s.author           = { 'Abdulrahman Qasem' => 'Abdulrahmanq1995@gmail.com' }
    s.source           = { :git => 'https://github.com/AbdulrahmanQasem95/DynamicMapper.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '11.0'
    s.osx.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'
    s.watchos.deployment_target = '4.0'
    s.swift_version = '5.0'
    s.requires_arc = true
    s.source_files = 'Classes/**/*.swift'
end
