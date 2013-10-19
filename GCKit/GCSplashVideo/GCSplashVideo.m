//
//  GCSplashVideo.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/04/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCSplashVideo.h"

static CompletitionBlock _completitionBlock;

@implementation GCSplashVideo

+ (GCSplashVideo *)presentVideo:(NSString *)video ofType:(NSString *)type completitionBlock:(CompletitionBlock)completitionBlock {
	return [[self alloc]initWithVideo:video ofType:type completitionBlock:completitionBlock];
}

- (GCSplashVideo *)initWithVideo:(NSString *)video ofType:(NSString *)type completitionBlock:(CompletitionBlock)completitionBlock {
    
    if (self = [super init]) {
        
        _completitionBlock = [completitionBlock copy];
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
        
        NSString *moviePath = [[NSBundle mainBundle] pathForResource:video ofType:type];
        
        self.playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:moviePath]];
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
            [_playerViewController.view setTransform:CGAffineTransformMakeRotation((M_PI / 2) * 3)]; }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            [_playerViewController.view setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        } else {
            [_playerViewController.view setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        }
        
        [_playerViewController.view setFrame:mainWindow.frame];
        
        [self.view setFrame:mainWindow.frame];
        [self.view addSubview:_playerViewController.view];
        
        MPMoviePlayerController *moviePlayer = [_playerViewController moviePlayer];
        [moviePlayer setControlStyle:MPMovieControlStyleNone];
        [moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayerDidFinishWithNotification:) 
                                                     name:MPMoviePlayerPlaybackDidFinishNotification 
                                                   object:moviePlayer];
        
        [mainWindow addSubview:self.view];
        [moviePlayer play];
    }
    
    return self;
}

- (void)moviePlayerDidFinishWithNotification:(NSNotification *)notification {
    _completitionBlock();
    [self.view removeFromSuperview];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
