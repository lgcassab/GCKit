//
//  GCImageView.h
//  GCKit
//
//  Created by Gustavo Cassab on 03/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

@interface GCImageView : UIImageView {
    
    NSURL *_url;
	
	NSURLConnection *_connection;
	NSMutableData *_receivedData;
	
	/* Spinner */
	UIActivityIndicatorView *_spinner;
	
	/* For progressive download */
	CGImageSourceRef _imageSource;
	CGFloat _fullHeight;
	CGFloat _fullWidth;
	NSUInteger _expectedSize;
    
    BOOL shouldShowProgressiveDownload;
}
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) BOOL shouldShowProgressiveDownload;

- (void)cancelLoading;
- (void)loadImageAtURL:(NSURL *)url;

+(id)imageViewWithFrame:(CGRect)frame imageFromUrl:(NSURL *)url backgroundColor:(UIColor *)backgroundColor showProgressiveDownload:(BOOL)showProgressiveDownload;

@end
