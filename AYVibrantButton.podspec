Pod::Spec.new do |s|
  s.name         = "AYVibrantButton"
  s.version      = "1.0.4"
  s.summary      = "A stylish button with iOS 8 vibrancy effect"
  s.homepage     = "https://github.com/a1anyip/AYVibrantButton"
  s.license      = { :type => "MIT" }
  s.author       = { "Alan Yip" => "alan@tweak.cc" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/a1anyip/AYVibrantButton.git", :tag => "1.0.4" }
  s.source_files = "AYVibrantButton"
  s.framework    = "UIKit"
  s.requires_arc = true
end
