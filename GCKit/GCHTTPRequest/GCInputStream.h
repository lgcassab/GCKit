//
//  GCInputStream.h
//  Part of GCHTTPRequest -> http://allseeing-i.com/GCHTTPRequest
//
//  Created by Ben Copsey on 10/08/2009.
//  Copyright 2009 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCHTTPRequest;

// This is a wrapper for NSInputStream that pretends to be an NSInputStream itself
// Subclassing NSInputStream seems to be tricky, and may involve overriding undocumented methods, so we'll cheat instead.
// It is used by GCHTTPRequest whenever we have a request body, and handles measuring and throttling the bandwidth used for uploading

@interface GCInputStream : NSObject {
	NSInputStream *stream;
	GCHTTPRequest *request;
}
+ (id)inputStreamWithFileAtPath:(NSString *)path request:(GCHTTPRequest *)request;
+ (id)inputStreamWithData:(NSData *)data request:(GCHTTPRequest *)request;

@property (retain, nonatomic) NSInputStream *stream;
@property (assign, nonatomic) GCHTTPRequest *request;
@end
