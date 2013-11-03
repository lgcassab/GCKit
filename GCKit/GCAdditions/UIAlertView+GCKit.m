//
//  UIAlertView+GCKit.m
//  VMB
//
//  Created by Gustavo Cassab on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+GCKit.h"

static GCDismissBlock _dismissBlock;
static GCCancelBlock _cancelBlock;

@implementation UIAlertView (Block)

+ (UIAlertView*) alertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(GCDismissBlock) dismissed
                           onCancel:(GCCancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message {
    
    return [UIAlertView alertViewWithTitle:title message:message cancelButtonTitle:NSLocalizedString(@"OK", @"")];
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex]) {
		_cancelBlock();
	} else {
        _dismissBlock(buttonIndex - 1); // cancel button is button 0
    }
}

#pragma mark - GCAlertView

+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration {
    GCAlertView *alertView = [GCAlertView alertWithImage:image duration:duration];
    return alertView;
}

+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion {
    GCAlertView *alertView = [GCAlertView alertWithImage:image duration:duration completion:completion];
    return alertView;
}

#pragma mark - Alerta de avaliação na AppStore

+(void)alertUserReviewWithAppID:(NSString *)appID
                          title:(NSString *)title
                        message:(NSString *)message
               buttonLaterTitle:(NSString *)buttonLaterTitle
              buttonReviewTitle:(NSString *)buttonReviewTitle
             buttonDisableTitle:(NSString *)buttonDisableTitle
                         cicles:(int)cicles {
    
    BOOL desabilitado = [[NSUserDefaults standardUserDefaults] boolForKey:@"gcUserReviewDisabled"];
	int count = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
	count++;
    
    if (count == cicles && !desabilitado) {
        
        [UIAlertView alertViewWithTitle:title
                                message:message
                      cancelButtonTitle:buttonLaterTitle
                      otherButtonTitles:[NSArray arrayWithObjects:buttonReviewTitle, buttonDisableTitle, nil]
                              onDismiss:^(int buttonIndex) {
                                  
                                  switch (buttonIndex) {
                                      case 0: {
                                          
                                          NSString *url = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&type=Purple+Software",appID];
                                          
										  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                                          
                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                          break;
                                      }
                                          
                                      case 1: {
                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                          break;
                                      }
                                  }
                                  
                              }
                               onCancel:^{}
         ];
        
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
	} else {
		[[NSUserDefaults standardUserDefaults] setInteger:count forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
}


@end
