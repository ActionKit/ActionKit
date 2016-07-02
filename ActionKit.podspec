Pod::Spec.new do |s|
  s.name         = "ActionKit"
  s.version      = "1.1"
  s.summary      = "ActionKit is a easy to use framework that wraps the target-action design paradigm into a closure design."
  s.description  = <<-DESC
                    ActionKit is a experimental, light-weight, easy to use framework that wraps the target-action design paradigm into a less verbose, cleaner format. It shortens target-action method calls by removing the target and replacing the selector with a closure.
                   DESC
  s.homepage     = "https://github.com/ActionKit/ActionKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Benjamin Hendricks" => "https://github.com/coolbnjmn", "Kev Choi" => "https://github.com/thisiskevinchoi" }
  s.source       = { :git => "https://github.com/ActionKit/ActionKit.git", :tag => s.version.to_s }
  s.platform 	 = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'ActionKit/*'
end