//
//  GCActionsPatternVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionsPatternVC.h"

@interface GCActionsPatternVC ()

@end

@implementation GCActionsPatternVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	_square = [[UIView alloc] initWithFrame:CGRectMake(135, 220, 50, 50)];
	[_square setBackgroundColor:[UIColor orangeColor]];
	[self.view addSubview:_square];
	
	_buttonLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[_buttonLeft setFrame:CGRectMake(20, 440, 120, 44)];
	[_buttonLeft setTitle:@"Left" forState:UIControlStateNormal];
	[_buttonLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_buttonLeft];
	
	_buttonRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[_buttonRight setFrame:CGRectMake(180, 440, 120, 44)];
	[_buttonRight setTitle:@"Right" forState:UIControlStateNormal];
	[_buttonRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_buttonRight];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {
	
}

- (void)buttonRightClicked:(UIButton *)button {
	
}

@end
