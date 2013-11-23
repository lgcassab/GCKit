//
//  GCActionScaleVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionScaleVC.h"

@interface GCActionScaleVC ()

@end

@implementation GCActionScaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActionScaleVC"];
	
	[self.buttonLeft  setTitle:@"Scale by .5" forState:UIControlStateNormal];
	[self.buttonRight setTitle:@"Scale to 2x" forState:UIControlStateNormal];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {
	[self.square runAction:[GCActionScaleBy actionWithDuration:0.35f scale:0.50f]];
}

- (void)buttonRightClicked:(UIButton *)button {
	[self.square runAction:[GCActionScaleTo actionWithDuration:0.35f scale:3]];
}

@end
