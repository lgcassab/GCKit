//
//  GCActionFadeVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionFadeVC.h"

@interface GCActionFadeVC ()

@end

@implementation GCActionFadeVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActionFadeVC"];
	
	[self.square setAlpha:0.50f];
	
	[self.buttonLeft  setTitle:@"Fade In" forState:UIControlStateNormal];
	[self.buttonRight setTitle:@"Fade Out" forState:UIControlStateNormal];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {
	[self.square runAction:[GCActionFadeIn actionWithDuration:0.35f]];
}

- (void)buttonRightClicked:(UIButton *)button {
	[self.square runAction:[GCActionFadeOut actionWithDuration:0.35f]];
}

@end
