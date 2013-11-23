//
//  GCEffectsVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 10/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCEffectsVC.h"
#import "GCKit.h"

@interface GCEffectsVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) id effect;
@end

@implementation GCEffectsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:@"GCEffectsVC" bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCEffects"];
}

#pragma mark - Actions

- (IBAction)buttonBorderClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectBorder borderWithColor:[UIColor redColor] width:2]];
	[_imageView addEffect:_effect];
}

- (IBAction)buttonShadowClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectShadow shadowWithColor:[UIColor darkGrayColor] opacity:0.70f offset:CGSizeMake(0, 3) radius:2.5f]];
	[_imageView addEffect:_effect];
}

- (IBAction)buttonGradientClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectGradient gradientWithTopColor:[UIColor whiteColor] bottomColor:[UIColor orangeColor]]];
	[_imageView addEffect:_effect];
}

- (IBAction)buttonShadowEllipticalClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectShadowElliptical effect]];
	[_imageView addEffect:_effect];
}

- (IBAction)buttonShadowTrapezoidalClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectShadowTrapezoidal effect]];
	[_imageView addEffect:_effect];
}

- (IBAction)buttonShadowPaperCurlClicked:(UIButton *)button {
	if (_effect) {
		[_imageView removeEffect:_effect];
	}
	[self setEffect:[GCEffectShadowPaperCurl shadowWithColor:[UIColor darkGrayColor] opacity:0.70f offset:CGSizeMake(1, 6) radius:2.5f]];
	[_imageView addEffect:_effect];
}

@end
