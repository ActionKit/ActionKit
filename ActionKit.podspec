Pod::Spec.new do |s|
  s.name          = "ActionKit"
  s.version       = "2.5.2"
  s.summary       = "ActionKit is an easy to use framework that wraps the target-action design paradigm into closures/blocks."
  s.description   = <<-DESC
                     ActionKit is a light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.
                    DESC
  s.homepage      = "https://github.com/ActionKit/ActionKit"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Benjamin Hendricks" => "https://github.com/coolbnjmn" }
  s.source        = { :git => "https://github.com/ActionKit/ActionKit.git", :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc  = true
  s.swift_version = '5.0'
  s.source_files  = 'ActionKit/*.swift'
end
