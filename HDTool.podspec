#
# Be sure to run `pod lib lint HDTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HDTool'
  s.version          = '0.1.0'
  s.summary          = 'A short description of HDTool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aqi2021/HDTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hsf' => 'huangsf2021@163.com' }
  s.source           = { :git => 'https://github.com/aqi2021/HDTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  
  # s.public_header_files = 'HDTool/Classes/HDTool.h'
  s.source_files = 'HDTool/Classes/HDTool.h'

  # Logger
  s.subspec 'Logger' do |ss|
    ss.source_files = 'HDTool/Classes/Logger/*.{h,m}'
  end

  # CrashProtector
  s.subspec 'CrashProtector' do |ss|
    ss.source_files = 'HDTool/Classes/CrashProtector/*.{h,m}'
  end

   
   
#  s.resource_bundles = {
#   'HDTool' => ['HDTool/Assets/*.png']
#  }
  s.frameworks = 'UIKit', 'Foundation'
#  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'HDUtil'
  s.dependency 'HDCategory'
  
  
end
