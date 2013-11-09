//
//  GCAnimationTransitionVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimationTransitionVC.h"
#import "GCKit.h"

@interface GCAnimationTransitionVC ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation GCAnimationTransitionVC {
	#define kTransitionDelay 0.35f
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCAnimationTransition"];
	[_label setText:[self now]];
}

#pragma mark - Private Methods

- (NSString *)now {
	return [NSString stringWithFormat:@"%@", [NSDate today]];
}

#pragma mark - Actions

- (IBAction)buttonFadeClicked:(UIButton *)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypeFade]];
	[_label setText:[self now]];
}

- (IBAction)buttonFromBottomClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypePush
													transitionSubtype:kGCTransitionTypeFromTop]];

	[_label setText:[self now]];
}

- (IBAction)buttonFromLeftClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypePush
													transitionSubtype:kGCTransitionTypeFromLeft]];
	[_label setText:[self now]];
}

- (IBAction)buttonFromRightClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypePush
													transitionSubtype:kGCTransitionTypeFromRight]];
	[_label setText:[self now]];
}

- (IBAction)buttonFromTopClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypePush
													transitionSubtype:kGCTransitionTypeFromBottom]];
	[_label setText:[self now]];
}

- (IBAction)buttonMoveInClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypeMoveIn
													transitionSubtype:kGCTransitionTypeFromTop]];
	[_label setText:[self now]];
}

- (IBAction)buttonPushClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypePush]];
	[_label setText:[self now]];
}

- (IBAction)buttonRevealClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingLinear
													   transitionType:kGCTransitionTypeReveal]];
	[_label setText:[self now]];
}

@end
