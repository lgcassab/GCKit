//
//  AppDelegate.m
//  GCKit
//
//  Created by Gustavo Cassab on 16/10/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import "AppDelegate.h"
#import "GCKit.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Initializing GCKit.
	[GCKit sharedKit];
	
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
