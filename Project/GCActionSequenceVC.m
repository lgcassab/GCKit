//
//  GCActionSequenceVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionSequenceVC.h"

@interface GCActionSequenceVC ()

@end

@implementation GCActionSequenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActionSequenceVC"];
	
	[self.buttonLeft  setTitle:@"Sequence" forState:UIControlStateNormal];
	[self.buttonLeft setCenterX:self.view.centerX];
	
	[self.buttonRight setHidden:YES];
}

#pragma mark - Actions

- (void)buttonLeftClicked:(UIButton *)button {

	id action1   = [GCActionMoveTo actionWithDuration:0.35f position:CGPointMake(80, 110)];
	id action2   = [GCActionScaleBy actionWithDuration:0.35f scale:1.2f];
	id action3   = [GCActionRotateBy actionWithDuration:0.35f angle:-45];
	id action4   = [GCActionDelay actionWithDuration:0.50f];
	id function1 = [GCActionCallFunc actionWithTarget:self selector:@selector(myFunction1)];
	id action5   = [GCActionDelay actionWithDuration:0.50f];
	id action6   = [GCActionMoveTo actionWithDuration:0.35f position:CGPointMake(135, 220)];
	id action7   = [GCActionRotateTo actionWithDuration:0.35f angle:0.00f];
	id action8   = [GCActionScaleTo actionWithDuration:0.35f scale:1.00f];
	id action9   = [GCActionDelay actionWithDuration:0.50f];
	id function2 = [GCActionCallFunc actionWithTarget:self selector:@selector(myFunction2)];
	
	[self.square runAction:[GCActionSequence actions:action1,
							action2, action3, action4, function1, action5, action6, action7, action8, action9, function2, nil]];
}

- (void)myFunction1 {
	[self.square setBackgroundColor:[UIColor greenColor]];
}

- (void)myFunction2 {
	[self.square setBackgroundColor:[UIColor orangeColor]];
}

@end
