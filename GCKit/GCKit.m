//
//  GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCKit.h"

@implementation GCKit

static GCKit *sharedKit = nil;

+ (GCKit *)sharedKit {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedKit = [[GCKit alloc] init];
    });
    return sharedKit;
}

+ (id)alloc {
	NSAssert(sharedKit == nil, @"Attempted to allocate a second instance of GCKit.");
	return [super alloc];
}

-(id) init {
	
	[GCActionManager sharedManager];
	NSLog(@"GCKit %@" , GCKitVersion);
    
    if (iPadDevice)
        [GCPopController sharedController];
    
    [GCTextFieldDelegate sharedDelegate];
    
    _gcMailComposer = nil;
    
	return self;
}

#pragma mark - Public Methods

- (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)openSiteInSafariWithUrlString:(NSString *)urlString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

//-(void)showAlertFuncionalidadeNaoImplementada {
//    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Funcionalidade ainda não implementada"];
//}

//-(void)showAlertInternetNotAvailable {
//    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Acesso a Internet não está disponível"];
//}

//-(BOOL)internetConnectionIsAvailable {
//	
//	BOOL retorno = YES;
//	
//	if ([[GCReachability reachabilityForInternetConnection] currentReachabilityStatus] == GCNotReachable) {
//		retorno = NO;
//	}
//	
//	return retorno;
//}


//-(void)alertUserReviewWithAppID:(NSString *)appID
//                          title:(NSString *)title
//                        message:(NSString *)message
//               buttonLaterTitle:(NSString *)buttonLaterTitle
//              buttonReviewTitle:(NSString *)buttonReviewTitle
//             buttonDisableTitle:(NSString *)buttonDisableTitle
//                         cicles:(int)cicles {
//    
//    BOOL desabilitado = [[NSUserDefaults standardUserDefaults] boolForKey:@"gcUserReviewDisabled"];
//	int count = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	count++;
//    
//    if (count == cicles && !desabilitado) {
//        
//        [UIAlertView alertViewWithTitle:title
//                                message:message
//                      cancelButtonTitle:buttonLaterTitle
//                      otherButtonTitles:[NSArray arrayWithObjects:buttonReviewTitle, buttonDisableTitle, nil]
//                              onDismiss:^(int buttonIndex) {
//                                  
//                                  switch (buttonIndex) {
//                                      case 0: {
//                                          
//                                          NSString *url = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&type=Purple+Software",appID];
//                                          
//                                          [self openSiteInSafariWithUrlString:url];
//                                          
//                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
//                                          [[NSUserDefaults standardUserDefaults] synchronize];
//                                          break;
//                                      }
//                                          
//                                      case 1: {
//                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
//                                          [[NSUserDefaults standardUserDefaults] synchronize];
//                                          break;
//                                      }
//                                  }
//                                  
//                              }
//                               onCancel:^{}
//         ];
//        
//		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	} else {
//		[[NSUserDefaults standardUserDefaults] setInteger:count forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	}
//	
//	[[NSUserDefaults standardUserDefaults] synchronize];
//}

@end
