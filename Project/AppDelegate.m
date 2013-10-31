//
//  AppDelegate.m
//  GCKit
//
//  Created by Gustavo Cassab on 16/10/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import "AppDelegate.h"
#import "GCKit.h"
#import "MainMenuVC.h"

@interface AppDelegate ( )
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Initializing GCKit.
	[GCKit sharedKit];
	
	MainMenuVC *mainMenu = [MainMenuVC new];
	_navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenu];
	
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[_window setRootViewController:_navigationController];
	[_window makeKeyAndVisible];
	
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
