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
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
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

- (NSUInteger)transitionType {
	NSUInteger transition = 0;
	switch ([_segmentedControl selectedSegmentIndex]) {
		case 0 : transition = kGCTransitionTypeMoveIn; break;
		case 1 : transition = kGCTransitionTypePush;  break;
		case 2 : transition = kGCTransitionTypeReveal;  break;
	}
	return transition;
}

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
													   transitionType:[self transitionType]
													transitionSubtype:kGCTransitionTypeFromTop]];

	[_label setText:[self now]];
}

- (IBAction)buttonFromLeftClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingEasyIn
													   transitionType:[self transitionType]
													transitionSubtype:kGCTransitionTypeFromLeft]];
	[_label setText:[self now]];
}

- (IBAction)buttonFromRightClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingEaseOut
													   transitionType:[self transitionType]
													transitionSubtype:kGCTransitionTypeFromRight]];
	[_label setText:[self now]];
}

- (IBAction)buttonFromTopClicked:(id)sender {
	[_label addAnimation:[GCAnimationTransition animationWithDuration:kTransitionDelay
													   timingFunction:kGCTransitionTimingEaseInEaseOut
													   transitionType:[self transitionType]
													transitionSubtype:kGCTransitionTypeFromBottom]];
	[_label setText:[self now]];
}

@end
