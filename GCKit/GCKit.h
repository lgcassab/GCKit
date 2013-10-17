//
//  GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#define GCKitVersion @"1.90.0"

#define kGCBadgeGlobalTab 6154378

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

#define iPadDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//#import <GCKit/GCActionManager.h>
//#import <GCKit/GCAction.h>
//#import <GCKit/GCEffect.h>
//#import <GCKit/GCEffectGlobal.h>
//#import <GCKit/GCAnimationGlobal.h>

// Additions
//#import <GCKit/UIAlertView+GCKit.h>
//#import <GCKit/UIActionSheet+GCKit.h>
#import "NSString+GCKit.h"
//#import <GCKit/UIView+GCKit.h>
//#import <GCKit/UIWindow+GCKit.h>
//#import <GCKit/UIColor+GCKit.h>
//#import <GCKit/UIFont+GCKit.h>
//#import <GCKit/UITableView+GCKit.h>
//#import <GCKit/UIImage+GCKit.h>
//#import <GCKit/UIToolbar+GCKit.h>
//#import <GCKit/UIWebView+GCKit.h>
//#import <GCKit/NSDate+GCKit.h>
//#import <GCKit/UIScreen+GCKit.h>
//#import <GCKit/NSNumberFormatter+GCKit.h>
//#import <GCKit/UIButton+GCKit.h>
//#import <GCKit/UIViewController+GCKit.h>
//#import <GCKit/UIImageView+GCKit.h>
//#import <GCKit/NSObject+GCKit.h>
//#import <GCKit/UITextField+GCKit.h>
//#import <GCKit/UITextView+GCKit.h>
//#import <GCKit/CLPlacemark+GCKit.h>
//#import <GCKit/NSTimer.h>

// Pickers
//#import <GCKit/GCPicker.h>
//#import <GCKit/GCPickerDate.h>
//#import <GCKit/GCPickerDateTime.h>

// Controllers
//#import <GCKit/GCTableController.h>
//#import <GCKit/GCVerticalTabController.h>
//#import <GCKit/GCTabBarController.h>

// GCDatabase
//#import <GCKit/GCDatabase.h>

// Visual
//#import <GCKit/GCTableCellBadgeView.h>
//#import <GCKit/GCBadgeView.h>
//#import <GCKit/GCCustomColoredAccessory.h>
//#import <GCKit/GCSplashVideo.h>

// Diversos
//#import <GCKit/GCBarButtonImageItem.h>
//#import <GCKit/GCImageView.h>
//#import <GCKit/GCReachability.h>
//#import <GCKit/GCAlertView.h>
//#import <GCKit/GCAlertTableView.h>
//#import <GCKit/GCTextFieldDelegate.h>

// GCProgressHud
//#import <GCKit/GCProgressHud.h>

// Criptografia
//#import "NSData+Base64.h"
//#import "GCEncrypt.h"

// GCFileManager
//#import <GCKit/GCFileManager.h>

// PopController
//#import <GCKit/GCPopController.h>

// GCParserCSV
//#import <GCKit/GCCSV.h>

// GCHTTPRequest
//#import <GCKit/GCFormDataRequest.h>

// GCEgoImageView
//#import <GCKit/GCEgoImageView.h>

// GCParserXML
//#import <GCKit/GCParserXML.h>

// GCKeychain
//#import <GCKit/GCKeychain.h>

// GCMailComposer
//#import <GCKit/GCMailcomposer.h>

// GCYoutube
//#import <GCKit/GCYoutube.h>

@interface GCKit : NSObject {
    
}
//@property(nonatomic, retain) GCMailComposer *gcMailComposer;

+ (GCKit *)sharedKit;

#pragma mark - Public Methods

- (NSString *)appVersion;
- (void)openSiteInSafariWithUrlString:(NSString *)urlString;

//-(CGSize)screenSize;

//-(BOOL)internetConnectionIsAvailable;
//-(void)showAlertFuncionalidadeNaoImplementada;
//-(void)showAlertInternetNotAvailable;



//-(void)alertUserReviewWithAppID:(NSString *)appID
//                          title:(NSString *)title
//                        message:(NSString *)message
//               buttonLaterTitle:(NSString *)buttonLaterTitle
//              buttonReviewTitle:(NSString *)buttonReviewTitle
//             buttonDisableTitle:(NSString *)buttonDisableTitle
//                         cicles:(int)cicles;

//- (NSArray *)arrayWithEstadosBrasileiros;

//- (BOOL)validateBirthDate:(NSString *)birthDate;
//- (BOOL)validateEmail:(NSString *)emailString;
//- (BOOL)validateCPF:(NSString *)cpf;
//- (BOOL)validateUrl:(NSString *)url;
//- (BOOL)validatePhone:(NSString *)phone;

@end

//#define MemoryWarning() [[UIApplication sharedApplication] _performMemoryWarning]
