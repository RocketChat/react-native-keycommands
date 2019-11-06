require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name           = "KeyCommands"
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['homepage']
  s.source       = { :git => "https://github.com/RocketChat/react-native-keycommands.git" }
  s.platform       = :ios, '7.0'

  s.source_files  = "ios/**/*.{h,m}"

  s.dependency 'React'
end
