#
# Be sure to run `pod lib lint Overlays.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Overlays'
  s.platform         = :ios
  s.ios.deployment_target = '9.0'
  s.version          = '0.1.0'
  s.summary          = 'Show any view atop of a view controller content.'
  s.homepage         = 'https://github.com/npu3pak/ios-lib-overlays'
  s.documentation_url = 'https://npu3pak.github.io/ios-lib-overlays'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeniy Safronov' => 'evsafronov.personal@yandex.ru' }
  s.source           = { :git => 'https://github.com/npu3pak/ios-lib-overlays.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.source_files = 'Overlays/Classes/**/*'

  s.description      = <<-DESC
Overlays is a library for displaying an empty list message or a loading indicator. You can show any custom view atop of a view controller content.
                       DESC

end