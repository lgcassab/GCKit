//
//  GCImageView.m
//  GCKit
//
//  Created by Gustavo Cassab on 03/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCImageView.h"
#import "GCKit.h"

@interface GCImageView (Private)
-(id)initWithFrame:(CGRect)frame imageFromUrl:(NSURL *)url backgroundColor:(UIColor *)backgroundColor showProgressiveDownload:(BOOL)showProgressiveDownload;
@end

static NSCache *_imageCache = nil;

@implementation GCImageView
@synthesize url = _url;
@synthesize shouldShowProgressiveDownload;

+(id)imageViewWithFrame:(CGRect)frame imageFromUrl:(NSURL *)url backgroundColor:(UIColor *)backgroundColor showProgressiveDownload:(BOOL)showProgressiveDownload {
    return [[self alloc]initWithFrame:frame imageFromUrl:url backgroundColor:backgroundColor showProgressiveDownload:showProgressiveDownload];
}

-(id)initWithFrame:(CGRect)frame imageFromUrl:(NSURL *)url backgroundColor:(UIColor *)backgroundColor showProgressiveDownload:(BOOL)showProgressiveDownload {
    self=[super initWithFrame:frame];
    if (self) {
        self.url = nil;
        self.shouldShowProgressiveDownload = showProgressiveDownload;
    }
    
    return self;
}

- (void)loadImageAtURL:(NSURL *)url {
    
	if ([NSThread isMainThread]) {
		[self performSelectorInBackground:@selector(loadImageAtURL:) withObject:url];
		return;
	}
	
	@autoreleasepool {
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
		
		_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
		[_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
		[_connection start];
		
		CFRunLoopRun();
	}
}

- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	
	if (!self.image && _url && !_connection && self.superview) {
		UIImage *image = [_imageCache objectForKey:_url];
		
		if (image) {
			self.image = image;
			_fullWidth = image.size.width;
			_fullHeight = image.size.height;
			
			// for unknown reasons direct notify does not work below iOS 5
			[self performSelector:@selector(notify) withObject:nil afterDelay:0.0];
			return;
		} 
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
		[_spinner startAnimating];
		[self addSubview:_spinner];
		
		[self loadImageAtURL:_url];
	}	
}

#pragma mark - Progressive Image

-(CGImageRef)newTransitoryImage:(CGImageRef)partialImg {
    
	const size_t height = CGImageGetHeight(partialImg);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef bmContext = CGBitmapContextCreate(NULL, _fullWidth, _fullHeight, 8, _fullWidth * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease(colorSpace);
    
	if (!bmContext) {
		return NULL;
	}
    
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = _fullWidth, .size.height = height}, partialImg);
	CGImageRef goodImageRef = CGBitmapContextCreateImage(bmContext);
	CGContextRelease(bmContext);
	return goodImageRef;
}

- (void)createAndShowProgressiveImage {
    
	if (!_imageSource) {
		return;
	}
	
	/* For progressive download */
	const NSUInteger totalSize = [_receivedData length];
	CGImageSourceUpdateData(_imageSource, (__bridge CFDataRef)_receivedData, (totalSize == _expectedSize) ? true : false);
	
	if (_fullHeight > 0 && _fullWidth > 0) {
        
		CGImageRef image = CGImageSourceCreateImageAtIndex(_imageSource, 0, NULL);
        
		if (image) {
			CGImageRef imgTmp = [self newTransitoryImage:image]; // iOS fix to correctly handle JPG see : http://www.cocoabyss.com/mac-os-x/progressive-image-download-imageio/
            
			if (imgTmp) {
				UIImage *image = [[UIImage alloc] initWithCGImage:imgTmp];
				[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
				
				CGImageRelease(imgTmp);
			}
			CGImageRelease(image);
		}
        
	} else {
        
		CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(_imageSource, 0, NULL);
        
		if (properties) {
			CFTypeRef val = CFDictionaryGetValue(properties, kCGImagePropertyPixelHeight);
            
			if (val)
				CFNumberGetValue(val, kCFNumberFloatType, &_fullHeight);
            
			val = CFDictionaryGetValue(properties, kCGImagePropertyPixelWidth);
            
			if (val)
				CFNumberGetValue(val, kCFNumberFloatType, &_fullWidth);
            
			CFRelease(properties);
		}
	}
}

#pragma mark - Notification

- (void)notify {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGSize:CGSizeMake(_fullWidth, _fullHeight)], @"ImageSize", _url, @"ImageURL", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GCImageViewDidFinishLoading" object:nil userInfo:userInfo];
}

#pragma mark NSURL Loading

- (void)completeDownloadWithData:(NSData *)data {
	UIImage *image = [[UIImage alloc] initWithData:data];
	
	if (!image) {
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
		[[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
	}
	
	self.image = image;
	_fullWidth = image.size.width;
	_fullHeight = image.size.height;
	
	//self.bounds = CGRectMake(0, 0, _fullWidth, _fullHeight);
	
	[self notify];
	
    #ifdef DT_USE_THREAD_SAFE_INITIALIZATION
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            _imageCache = [[NSCache alloc] init];
        });
    #else
        if (!_imageCache) {
            _imageCache = [[NSCache alloc] init];
        }
    #endif
	
	if (_url)
		[_imageCache setObject:image forKey:_url];
	
	[_spinner removeFromSuperview];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
	// every time we get an response it might be a forward, so we discard what data we have
	_receivedData = nil;
	
	// does not fire for local file URLs
	if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *httpResponse = (id)response;
		
		if (![[httpResponse MIMEType] hasPrefix:@"image"]) {
			[self cancelLoading];
			return;
		}
	}
	
	/* For progressive download */
	_fullWidth = _fullHeight = -1.0f;
	_expectedSize = (NSUInteger)[response expectedContentLength];
	
	_receivedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_receivedData appendData:data];
	
	if (!CGImageSourceCreateIncremental || !shouldShowProgressiveDownload)
		return;
	
	if (!_imageSource)
		_imageSource = CGImageSourceCreateIncremental(NULL);
	
	[self createAndShowProgressiveImage];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
	if (_receivedData) {
		[self performSelectorOnMainThread:@selector(completeDownloadWithData:) withObject:_receivedData waitUntilDone:YES];
		_receivedData = nil;
	}
	
	_connection = nil;
	
	/* For progressive download */
	if (_imageSource)
		CFRelease(_imageSource), _imageSource = NULL;
	
	CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
	[[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
	
	_connection = nil;
	_receivedData = nil;
	
	/* For progressive download */
	if (_imageSource)
		CFRelease(_imageSource), _imageSource = NULL;
	
	CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - Memory management

- (void)cancelLoading {
	[_connection cancel];
	_connection = nil;
	_receivedData = nil;
}

- (void)removeFromSuperview {
	[super removeFromSuperview];
}

- (void)dealloc {
    [_connection cancel];
}

@end
