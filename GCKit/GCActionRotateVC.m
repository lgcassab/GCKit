//
//  GCActionRotateVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionRotateVC.h"

@interface GCActionRotateVC ()

@end

@implementation GCActionRotateVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActionRotateVC"];
	
	[self.buttonLeft  setTitle:@"Rotate By 15º" forState:UIControlStateNormal];
	[self.buttonRight setTitle:@"Rotate To 45º" forState:UIControlStateNormal];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {
	[self.square runAction:[GCActionRotateBy actionWithDuration:0.35f angle:15.0f]];
}

- (void)buttonRightClicked:(UIButton *)button {
	[self.square runAction:[GCActionRotateTo actionWithDuration:0.35f angle:45.0f]];
}

@end
