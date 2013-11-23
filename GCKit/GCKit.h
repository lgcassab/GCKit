//
//  GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#define GCKitVersion @"1.90.0"

#ifndef __OPTIMIZE__
#	define GCLog( s, ... ) NSLog( @"<%@:%d (%@)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#	define GCLog( s, ... )
#endif

#ifndef ccp
#define ccp(x,y) CGPointMake(x,y)
#endif

#ifndef RGB
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#endif

#ifndef RGBA
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#endif

#define gcKit [GCKit sharedKit]

#define iPadDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define __(str) NSLocalizedString(str, nil)

#import "GCActionManager.h"
#import "GCAction.h"
#import "GCEffect.h"
#import "GCEffectGlobal.h"
#import "GCAnimationGlobal.h"

// Additions
#import "UIAlertView+GCKit.h"
#import "UIActionSheet+GCKit.h"
#import "NSString+GCKit.h"
#import "UIView+GCKit.h"
#import "UIWindow+GCKit.h"
#import "UIColor+GCKit.h"
#import "UIFont+GCKit.h"
#import "UITableView+GCKit.h"
#import "UIImage+GCKit.h"
#import "UIToolbar+GCKit.h"
#import "UIWebView+GCKit.h"
#import "NSDate+GCKit.h"
#import "UIScreen+GCKit.h"
#import "NSNumberFormatter+GCKit.h"
#import "UIButton+GCKit.h"
#import "UIImageView+GCKit.h"
#import "NSObject+GCKit.h"
#import "UITextField+GCKit.h"
#import "UITextView+GCKit.h"
#import "CLPlacemark+GCKit.h"
#import "NSArray+GCKit.h"
#import "NSTimer+GCKit.h"

// Pickers
#import "GCPicker.h"
#import "GCPickerDate.h"
#import "GCPickerDateTime.h"

// Controllers
#import "GCTableController.h"
#import "GCTabBarController.h"

// GCDatabase
#import "GCDatabase.h"

// Visual
#import "GCTableCellBadgeView.h"
#import "GCBadgeView.h"
#import "GCCustomColoredAccessory.h"
#import "GCSplashVideo.h"

// Diversos
#import "GCBarButtonImageItem.h"
#import "GCImageView.h"
#import "GCReachability.h"
#import "GCAlertView.h"
#import "GCAlertTableView.h"
#import "GCTextFieldDelegate.h"

// GCProgressHud
#import "GCProgressHud.h"

// Criptografia
#import "NSData+Base64.h"
#import "GCEncrypt.h"

// GCFileManager
#import "GCFileManager.h"

// GCPopController
#import "GCPopController.h"

// GCParserCSV
#import "GCCSV.h"

// GCHTTPRequest
#import "GCFormDataRequest.h"

// GCEgoImageView
#import "GCEgoImageView.h"

// GCParserXML
#import "GCParserXML.h"

// GCKeychain
#import "GCKeychain.h"

// GCMailComposer
#import "GCMailcomposer.h"

// GCValidator
#import "GCValidator.h"

// GCYoutube
#import "GCYoutube.h"

@interface GCKit : NSObject {
    
}
@property(nonatomic, strong) GCMailComposer *gcMailComposer;

+ (GCKit *)sharedKit;

#pragma mark - Public Methods

- (NSString *)appVersion;
- (void)openSiteInSafariWithUrlString:(NSString *)urlString;

-(void)showAlertFuncionalidadeNaoImplementada;
-(void)showAlertInternetNotAvailable;

-(BOOL)internetConnectionIsAvailable;

@end
