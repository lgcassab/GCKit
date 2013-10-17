Pod::Spec.new do |s|
  s.name     = 'GCKit'
  s.version  = '1.90.0'
  s.license  = 'MIT'
  s.summary  = 'One more iOS framework.'
  s.homepage = 'https://github.com/lgcassab/GCKit'
  s.authors  = { 'Gustavo Cassab' => 'lgcassab@mac.com' }
  s.source   = { :git => 'https://github.com/lgcassab/GCKit.git', :tag => "1.90.0" }
  s.requires_arc = true
  s.platform = :ios
  s.ios.deployment_target = '6.0'

  s.public_header_files = 'GCKit/*.h'
  s.source_files = 'GCKit/GCKit.h'
  
  s.prefix_header_contents = <<-EOS
  #import "GCKit.h"
  EOS
  
  s.ios.frameworks = 'Accounts', 
	  				 'CFNetwork', 
					 'CoreGraphics', 
					 'CoreLocation', 
					 'Foundation', 
					 'ImageIO', 
					 'libsqlite3', 
					 'libxml2', 
					 'libz', 
					 'MediaPlayer', 
					 'MessageUI', 
					 'MobileCoreService', 
					 'OpenGLES', 
					 'QuartzCore', 
					 'SystemConfiguration', 
					 'Security', 
					 'Social', 
					 'UIKit'
  
  s.subspec 'GCAdditions' do |ss|
    ss.ios.public_header_files = 'GCKit/GCAdditions/*.h'
    ss.ios.source_files = 'GCKit/GCAdditions/*.{h,m}'
  end
end
