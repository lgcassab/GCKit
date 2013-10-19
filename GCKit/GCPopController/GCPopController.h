//
//  GCPopController.h
//  GCKit
//
//  Created by Gustavo Cassab on 09/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GCPopControllerDelegate;

@interface GCPopController : UIViewController <UIPopoverControllerDelegate> {
    
}
@property(nonatomic, strong) UIPopoverController *popoverController;
@property(nonatomic, assign) id <GCPopControllerDelegate> delegate;

+ (GCPopController *)sharedController;

- (void)dismiss;
- (void)showViewController:(UIViewController *)viewController fromBarButtonItem:(UIBarButtonItem *)button;
- (void)showViewController:(UIViewController *)viewController fromButton:(UIButton *)button;
- (void)showViewController:(UIViewController *)viewController fromButton:(UIButton *)button arrowDirection:(UIPopoverArrowDirection)arrow;

- (void)showViewController:(UIViewController *)viewController fromFrame:(CGRect)frame inView:(UIView *)view;
- (void)showViewController:(UIViewController *)viewController fromFrame:(CGRect)frame inView:(UIView *)view arrowDirection:(UIPopoverArrowDirection)arrow;

@end

@protocol GCPopControllerDelegate <NSObject>
@optional
- (void)gcPopoverDismissedSuccessfuly;
@end
