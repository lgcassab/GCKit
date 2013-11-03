//
//  GCDownloadCache.h
//  Part of GCHTTPRequest -> http://allseeing-i.com/GCHTTPRequest
//
//  Created by Ben Copsey on 01/05/2010.
//  Copyright 2010 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCCacheDelegate.h"

@interface GCDownloadCache : NSObject <GCCacheDelegate> {
	
	// The default cache policy for this cache
	// Requests that store data in the cache will use this cache policy if their cache policy is set to GCUseDefaultCachePolicy
	// Defaults to GCAskServerIfModifiedWhenStaleCachePolicy
	GCCachePolicy defaultCachePolicy;
	
	// The directory in which cached data will be stored
	// Defaults to a directory called 'GCHTTPRequestCache' in the temporary directory
	NSString *storagePath;
	
	// Mediates access to the cache
	NSRecursiveLock *accessLock;
	
	// When YES, the cache will look for cache-control / pragma: no-cache headers, and won't reuse store responses if it finds them
	BOOL shouldRespectCacheControlHeaders;
}

// Returns a static instance of an GCDownloadCache
// In most circumstances, it will make sense to use this as a global cache, rather than creating your own cache
// To make GCHTTPRequests use it automatically, use [GCHTTPRequest setDefaultCache:[GCDownloadCache sharedCache]];
+ (id)sharedCache;

// A helper function that determines if the server has requested data should not be cached by looking at the request's response headers
+ (BOOL)serverAllowsResponseCachingForRequest:(GCHTTPRequest *)request;

@property (assign, nonatomic) GCCachePolicy defaultCachePolicy;
@property (retain, nonatomic) NSString *storagePath;
@property (retain) NSRecursiveLock *accessLock;
@property (assign) BOOL shouldRespectCacheControlHeaders;
@end
