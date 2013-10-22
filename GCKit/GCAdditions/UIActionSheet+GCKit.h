//
//  UIActionSheet+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBlockAdditions.h"

@interface UIActionSheet (GCKit) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(GCDismissBlock) dismissed
                    onCancel:(GCCancelBlock) cancelled;


+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(GCDismissBlock) dismissed
                     onCancel:(GCCancelBlock) cancelled;


+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                     fromRect:(CGRect)rect
                    onDismiss:(GCDismissBlock) dismissed
                     onCancel:(GCCancelBlock) cancelled;


+ (void) photoPickerWithTitle:(NSString*) title
                   showInView:(UIView*) view
                    presentVC:(UIViewController*) presentView
                onPhotoPicked:(GCPhotoPickedBlock) photoPicked
                     onCancel:(GCCancelBlock) cancelled;

+ (void) photoPickerWithTitle:(NSString *) title
			   useFrontCamera:(BOOL)frontCamera
                   showInView:(UIView *) view
                    presentVC:(UIViewController *)presentVC
                onPhotoPicked:(GCPhotoPickedBlock) photoPicked
                     onCancel:(GCCancelBlock) cancelled;

@end
