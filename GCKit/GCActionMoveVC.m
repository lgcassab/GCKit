//
//  GCActionMoveVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionMoveVC.h"

@interface GCActionMoveVC ()

@end

@implementation GCActionMoveVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActionMoveVC"];
	
	[self.buttonLeft  setTitle:@"Move By 10x10" forState:UIControlStateNormal];
	[self.buttonRight setTitle:@"Move To 60x120" forState:UIControlStateNormal];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {
	[self.square runAction:[GCActionMoveBy actionWithDuration:0.35f position:CGPointMake(10, 10)]];
}

- (void)buttonRightClicked:(UIButton *)button {
	[self.square runAction:[GCActionMoveTo actionWithDuration:0.35f position:CGPointMake(60, 120)]];
}

@end
