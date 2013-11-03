//
//  UIAlertView+GCKit.h
//  VMB
//
//  Created by Gustavo Cassab on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCBlockAdditions.h"
#import "GCAlertView.h"

@interface UIAlertView (GCKit) <UIAlertViewDelegate>

#pragma mark - UIAlertView

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(GCDismissBlock) dismissed
                           onCancel:(GCCancelBlock) cancelled;

#pragma mark - GCAlertView

+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration;
+ (GCAlertView *)alertWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion;

#pragma mark - Alerta de avaliação na AppStore

+(void)alertUserReviewWithAppID:(NSString *)appID
                          title:(NSString *)title
                        message:(NSString *)message
               buttonLaterTitle:(NSString *)buttonLaterTitle
              buttonReviewTitle:(NSString *)buttonReviewTitle
             buttonDisableTitle:(NSString *)buttonDisableTitle
                         cicles:(int)cicles;

@end
