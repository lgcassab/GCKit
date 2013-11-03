//
//  GCEgoImageLoader.h
//  GCEgoImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#ifndef __GCEgoIL_USE_BLOCKS
#define __GCEgoIL_USE_BLOCKS 0
#endif

#ifndef __GCEgoIL_USE_NOTIF
#define __GCEgoIL_USE_NOTIF 1
#endif

@protocol GCEgoImageLoaderObserver;
@interface GCEgoImageLoader : NSObject/*<NSURLConnectionDelegate>*/ {
@private
	NSDictionary* _currentConnections;
	NSMutableDictionary* currentConnections;
	#if __GCEgoIL_USE_BLOCKS
	dispatch_queue_t _operationQueue;
	#endif

	NSLock* connectionsLock;
}

+ (GCEgoImageLoader*)sharedImageLoader;

- (BOOL)isLoadingImageURL:(NSURL*)aURL;

#if __GCEgoIL_USE_NOTIF
- (void)loadImageForURL:(NSURL*)aURL observer:(id<GCEgoImageLoaderObserver>)observer;
- (UIImage*)imageForURL:(NSURL*)aURL shouldLoadWithObserver:(id<GCEgoImageLoaderObserver>)observer;

- (void)removeObserver:(id<GCEgoImageLoaderObserver>)observer;
- (void)removeObserver:(id<GCEgoImageLoaderObserver>)observer forURL:(NSURL*)aURL;
#endif

#if __GCEgoIL_USE_BLOCKS
- (void)loadImageForURL:(NSURL*)aURL completion:(void (^)(UIImage* image, NSURL* imageURL, NSError* error))completion;
- (void)loadImageForURL:(NSURL*)aURL style:(NSString*)style styler:(UIImage* (^)(UIImage* image))styler completion:(void (^)(UIImage* image, NSURL* imageURL, NSError* error))completion;
#endif

- (BOOL)hasLoadedImageURL:(NSURL*)aURL;
- (void)cancelLoadForURL:(NSURL*)aURL;

- (void)clearCacheForURL:(NSURL*)aURL;
- (void)clearCacheForURL:(NSURL*)aURL style:(NSString*)style;

@property(nonatomic,strong) NSDictionary* currentConnections;
@end

@protocol GCEgoImageLoaderObserver<NSObject>
@optional
- (void)imageLoaderDidLoad:(NSNotification*)notification; // Object will be GCEgoImageLoader, userInfo will contain imageURL and image
- (void)imageLoaderDidFailToLoad:(NSNotification*)notification; // Object will be GCEgoImageLoader, userInfo will contain error
@end
