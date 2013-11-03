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
					 
  s.subspec 'GCActions' do |ss|
    ss.ios.public_header_files = 'GCKit/GCActions/*.h'
    ss.ios.source_files = 'GCKit/GCActions/*.{h,m}'
  end
  
  s.subspec 'GCAdditions' do |ss|
    ss.ios.public_header_files = 'GCKit/GCAdditions/*.h'
    ss.ios.source_files = 'GCKit/GCAdditions/*.{h,m}'
  end
  
  s.subspec 'GCAlertTableView' do |ss|
    ss.ios.public_header_files = 'GCKit/GCAlertTableView/*.h'
    ss.ios.source_files = 'GCKit/GCAlertTableView/*.{h,m}'
  end

  s.subspec 'GCAnimation' do |ss|
    ss.ios.public_header_files = 'GCKit/GCAnimation/*.h'
    ss.ios.source_files = 'GCKit/GCAnimation/*.{h,m}'
  end
  
  s.subspec 'GCBadgeView' do |ss|
    ss.ios.public_header_files = 'GCKit/GCBadgeView/*.h'
    ss.ios.source_files = 'GCKit/GCBadgeView/*.{h,m}'
  end
  
  s.subspec 'GCDatabase' do |ss|
    ss.ios.public_header_files = 'GCKit/GCDatabase/*.h'
    ss.ios.source_files = 'GCKit/GCDatabase/*.{h,m}'
  end
  
  s.subspec 'GCEffects' do |ss|
    ss.ios.public_header_files = 'GCKit/GCEffects/*.h'
    ss.ios.source_files = 'GCKit/GCEffects/*.{h,m}'
  end
  
  s.subspec 'GCEncrypt' do |ss|
    ss.ios.public_header_files = 'GCKit/GCEncrypt/*.h'
    ss.ios.source_files = 'GCKit/GCEncrypt/*.{h,m}'
  end
  
  s.subspec 'GCFileManager' do |ss|
    ss.ios.public_header_files = 'GCKit/GCFileManager/*.h'
    ss.ios.source_files = 'GCKit/GCFileManager/*.{h,m}'
  end
  
	s.subspec 'GCHTTPRequest' do |ss|
    ss.ios.public_header_files = 'GCKit/GCHTTPRequest/*.h'
    ss.ios.source_files = 'GCKit/GCHTTPRequest/*.{h,m}'
  end

  s.subspec 'GCImageView' do |ss|
    ss.ios.public_header_files = 'GCKit/GCImageView/*.h'
    ss.ios.source_files = 'GCKit/GCImageView/*.{h,m}'
  end

  s.subspec 'GCKeychain' do |ss|
    ss.ios.public_header_files = 'GCKit/GCKeychain/*.h'
    ss.ios.source_files = 'GCKit/GCKeychain/*.{h,m}'
  end
  
  s.subspec 'GCMailComposer' do |ss|
    ss.ios.public_header_files = 'GCKit/GCMailComposer/*.h'
    ss.ios.source_files = 'GCKit/GCMailComposer/*.{h,m}'
  end
  
  s.subspec 'GCParserXML' do |ss|
    ss.ios.public_header_files = 'GCKit/GCParserXML/*.h'
    ss.ios.source_files = 'GCKit/GCParserXML/*.{h,m}'
	s.xcconfig = { 'HEADER_SEARCH_PATHS' => '/usr/include/libxml2' }
  end
  
  s.subspec 'GCPopController' do |ss|
    ss.ios.public_header_files = 'GCKit/GCPopController/*.h'
    ss.ios.source_files = 'GCKit/GCPopController/*.{h,m}'
  end
  
  s.subspec 'GCProgressHud' do |ss|
    ss.ios.public_header_files = 'GCKit/GCProgressHud/*.h'
    ss.ios.source_files = 'GCKit/GCProgressHud/*.{h,m}'
  end
  
  s.subspec 'GCReachability' do |ss|
    ss.ios.public_header_files = 'GCKit/GCReachability/*.h'
    ss.ios.source_files = 'GCKit/GCReachability/*.{h,m}'
  end
  
  s.subspec 'GCSplashVideo' do |ss|
    ss.ios.public_header_files = 'GCKit/GCSplashVideo/*.h'
    ss.ios.source_files = 'GCKit/GCSplashVideo/*.{h,m}'
  end
  
  s.subspec 'GCTableKit' do |ss|
    ss.ios.public_header_files = 'GCKit/GCTableKit/*.h'
    ss.ios.source_files = 'GCKit/GCTableKit/*.{h,m}'
  end
  
  s.subspec 'GCTextFieldDelegate' do |ss|
    ss.ios.public_header_files = 'GCKit/GCTextFieldDelegate/*.h'
    ss.ios.source_files = 'GCKit/GCTextFieldDelegate/*.{h,m}'
  end
  
  s.subspec 'GCYoutube' do |ss|
    ss.ios.public_header_files = 'GCKit/GCYoutube/*.h'
    ss.ios.source_files = 'GCKit/GCYoutube/*.{h,m}'
  end
  
end
