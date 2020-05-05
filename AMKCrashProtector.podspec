#
# Be sure to run `pod lib lint AMKCrashProtector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMKCrashProtector'
  s.version          = '0.1.0'
  s.summary          = 'Summary of AMKCrashProtector.'
  s.description      = <<-DESC
                        Description of AMKCrashProtector.
                       DESC
  s.homepage         = 'https://github.com/AndyM129/AMKCrashProtector'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AndyM129' => 'andy_m129@163.com' }
  s.source           = { :git => 'https://github.com/AndyM129/AMKCrashProtector.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'AMKCrashProtector/Classes/**/*'
end
