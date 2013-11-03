//
//  GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCKit.h"

@implementation GCKit

static GCKit *sharedKit = nil;

+ (GCKit *)sharedKit {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedKit = [[GCKit alloc] init];
    });
    return sharedKit;
}

+ (id)alloc {
	NSAssert(sharedKit == nil, @"Attempted to allocate a second instance of GCKit.");
	return [super alloc];
}

-(id) init {
	
	[GCActionManager sharedManager];
	NSLog(@"GCKit %@" , GCKitVersion);
    
    if (iPadDevice)
        [GCPopController sharedController];
    
    [GCTextFieldDelegate sharedDelegate];
    
    _gcMailComposer = nil;
    
	return self;
}

#pragma mark - Public Methods

- (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)openSiteInSafariWithUrlString:(NSString *)urlString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark - Alerts

-(void)showAlertFuncionalidadeNaoImplementada {
    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Funcionalidade ainda não implementada"];
}

-(void)showAlertInternetNotAvailable {
    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Acesso a Internet não está disponível"];
}

#pragma mark - Reachability

-(BOOL)internetConnectionIsAvailable {
	
	BOOL retorno = YES;
	
	if ([[GCReachability reachabilityForInternetConnection] currentReachabilityStatus] == GCNotReachable) {
		retorno = NO;
	}
	
	return retorno;
}

@end
