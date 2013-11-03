//
//  GCAlertView.h
//  GCKit
//
//  Created by Gustavo Cassab on 27/03/12.
//  Copyright (c) 2012 GCCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GCBlockAdditions.h"

@interface GCAlertView : UIAlertView {
    UIImage *newBodyImage;
    float newDuration;
    
    UIColor *newBodyColor;
}

#pragma mark - Alert with Image

+(id)alertWithImage:(UIImage *)image duration:(CGFloat )duration;
+(id)alertWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion;

-(id)initWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion;

#pragma mark - Alert With Color

+ (GCAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                          bodyColor:(UIColor *)bodyMessageColor;

+ (GCAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                          bodyColor:(UIColor *)bodyMessageColor
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (GCAlertView*) alertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message
                          bodyColor:(UIColor *)bodyMessageColor
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(GCDismissBlock)dismissed
                           onCancel:(GCCancelBlock)cancelled;

-(id)initWithTitle:(NSString *)title 
           message:(NSString *)message 
         bodyColor:(UIColor *)bodyMessageColor 
          delegate:(id)delegate 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ...;

#pragma mark - Overrides

+ (void)alertView:(GCAlertView *) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex;

@end
