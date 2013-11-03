//
//  GCEgoImageView.m
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

#import "GCEgoImageView.h"
#import "GCEgoImageLoader.h"

@implementation GCEgoImageView
@synthesize imageURL, placeholderImage, delegate;
@synthesize userObject;
@synthesize userObject2;
@synthesize userObject3;
@synthesize userObject4;
@synthesize userObject5;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<GCEgoImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
    
	if(imageURL) {
		[[GCEgoImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = aURL;
	}

	[[GCEgoImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[GCEgoImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		self.image = anImage;

		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
        }
	} else {
		self.image = self.placeholderImage;
	}
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[GCEgoImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[GCEgoImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
    
	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	self.image = anImage;
	[self setNeedsDisplay];
    
	if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
		[self.delegate imageViewLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
    
	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark -

- (void)dealloc {
	[[GCEgoImageLoader sharedImageLoader] removeObserver:self];
	self.imageURL = nil;
}

@end
