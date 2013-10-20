//
//  UIActionSheet+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIActionSheet+GCKit.h"

static GCDismissBlock _dismissBlock;
static GCCancelBlock _cancelBlock;
static GCPhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;

@implementation UIActionSheet (GCKit)

+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(GCDismissBlock) dismissed
                    onCancel:(GCCancelBlock) cancelled {
    [UIActionSheet actionSheetWithTitle:title 
                                message:message 
                 destructiveButtonTitle:nil 
                                buttons:buttonTitles 
                             showInView:view 
                              onDismiss:dismissed 
                               onCancel:cancelled];
}

+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(GCDismissBlock) dismissed
                     onCancel:(GCCancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id)[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles)
        [actionSheet addButtonWithTitle:thisButtonTitle];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancelar", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle)
        actionSheet.cancelButtonIndex ++;
    
    if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
}

+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                     fromRect:(CGRect)rect
                    onDismiss:(GCDismissBlock) dismissed
                     onCancel:(GCCancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id)[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles) {
        [actionSheet addButtonWithTitle:thisButtonTitle];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancelar", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle) {
        actionSheet.cancelButtonIndex ++;
    }
    
    if([view isKindOfClass:[UIView class]]) {
        if([view isKindOfClass:[UITabBar class]]) {
            [actionSheet showFromTabBar:(UITabBar*) view];
        } else if([view isKindOfClass:[UIBarButtonItem class]]) {
            [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
        } else {
            [actionSheet showFromRect:rect inView:view animated:YES];
        }
    }
    
}

+ (void) photoPickerWithTitle:(NSString *) title
                   showInView:(UIView *) view
                    presentVC:(UIViewController *) presentVC
                onPhotoPicked:(GCPhotoPickedBlock) photoPicked
                     onCancel:(GCCancelBlock) cancelled {

    _cancelBlock  = [cancelled copy];
    _photoPickedBlock  = [photoPicked copy];
    _presentVC = presentVC;
    
    int cancelButtonIndex = -1;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id)[self class]
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];
    
    
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Câmera", @"")];
		cancelButtonIndex ++;
	}
    
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Fotos", @"")];
		cancelButtonIndex ++;
	}
    
	[actionSheet addButtonWithTitle:NSLocalizedString(@"Cancelar", @"")];
	cancelButtonIndex ++;
    
    actionSheet.tag = kPhotoActionSheetTag;
	actionSheet.cancelButtonIndex = cancelButtonIndex;		 
    
	if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    
}

+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage)
        editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerOriginalImage];
    
    _photoPickedBlock(editedImage);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Dismiss the image selection and close the program
    [_presentVC dismissViewControllerAnimated:YES completion:nil];
    _cancelBlock();
}

+ (void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [actionSheet cancelButtonIndex]) {
		_cancelBlock();
	} else {
        
        if(actionSheet.tag == kPhotoActionSheetTag) {
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                buttonIndex ++;
            }
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                buttonIndex ++;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = (id)[self class];
            picker.allowsEditing = YES;
            
            if(buttonIndex == 1) {                
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else if(buttonIndex == 2) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
			[_presentVC presentViewController:picker animated:YES completion:nil];
            
        } else {
            _dismissBlock(buttonIndex);
        }
    }
}

@end
