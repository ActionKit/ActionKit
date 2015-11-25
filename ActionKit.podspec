Pod::Spec.new do |s|
  s.name         = "ActionKit"
  s.version      = "1.0"
  s.summary      = "ActionKit is a experimental, light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format."
  s.description  = <<-DESC
                    ActionKit is a experimental, light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.
                   DESC
  s.homepage     = "https://github.com/ActionKit/ActionKit"
  s.license      = 'MIT'
  s.author       = { "Paul Peelen" => "Paul@PaulPeelen.com" }
  s.source       = { :git => "https://github.com/ActionKit/ActionKit", :tag => s.version.to_s }
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source_files = 'ActionKit/*'
end