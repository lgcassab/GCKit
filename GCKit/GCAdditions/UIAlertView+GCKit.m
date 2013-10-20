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

//+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration {
//    GCAlertView *alertView = [GCAlertView alertWithImage:image duration:duration];
//    return alertView;
//}

//+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration completion:(Completion)completion {
//    GCAlertView *alertView = [GCAlertView alertWithImage:image duration:duration completion:completion];
//    return alertView;
//}

@end
