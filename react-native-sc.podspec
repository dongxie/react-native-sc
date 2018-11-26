require 'json'
package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "react-native-sc"
  s.version      = package['version']
  s.summary      = package['description']
  s.author       = package['author']

  s.homepage     = "https://github.com/dongxie/react-native-sc"

  s.license      = "MIT"
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dongxie/react-native-sc.git", :tag => "#{s.version}" }
  s.frameworks   = "AdSupport"
  s.source_files = "ios/sc/*.{h,m}"
  s.dependency "React"
end
