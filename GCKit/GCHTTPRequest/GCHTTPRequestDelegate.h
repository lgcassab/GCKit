//
//  GCHTTPRequestDelegate.h
//  Part of GCHTTPRequest -> http://allseeing-i.com/GCHTTPRequest
//
//  Created by Ben Copsey on 13/04/2010.
//  Copyright 2010 All-Seeing Interactive. All rights reserved.
//

@class GCHTTPRequest;

@protocol GCHTTPRequestDelegate <NSObject>

@optional

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
- (void)requestStarted:(GCHTTPRequest *)request;
- (void)request:(GCHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(GCHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(GCHTTPRequest *)request;
- (void)requestFailed:(GCHTTPRequest *)request;
- (void)requestRedirected:(GCHTTPRequest *)request;

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(GCHTTPRequest *)request didReceiveData:(NSData *)data;

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(GCHTTPRequest *)request;
- (void)proxyAuthenticationNeededForRequest:(GCHTTPRequest *)request;

@end
