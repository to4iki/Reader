Pod::Spec.new do |s|
  s.name             = 'Reader'
  s.version          = '0.1.0'
  s.summary          = "Reader monad in Swift"
  s.description      = <<-DESC
                          Reader, a wrapper for function that take some Input and produce Element.
                        DESC
  s.homepage         = 'https://github.com/to4iki/Reader'
  s.source_files     = 'Sources/Reader/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES', 'APPLICATION_EXTENSION_API_ONLY' => 'YES' }
  s.source           = { :git => 'https://github.com/to4iki/Reader.git', :tag => "#{s.version}" }
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Toshiki Takezawa' => 'tsk.take815@gmail.com' }
  s.social_media_url = 'https://twitter.com/to4iki'
  s.ios.deployment_target = '8.0'
  s.swift_version    = '4.0'
end
