//
//  GCEgoImageView.h
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

#import <UIKit/UIKit.h>
#import "GCEgoImageLoader.h"

@protocol GCEgoImageViewDelegate;
@interface GCEgoImageView : UIImageView<GCEgoImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<GCEgoImageViewDelegate> __weak delegate;
    
    id userObject;
    id userObject2;
    id userObject3;
    id userObject4;
    id userObject5;
}
@property(nonatomic, strong)id userObject;
@property(nonatomic, strong)id userObject2;
@property(nonatomic, strong)id userObject3;
@property(nonatomic, strong)id userObject4;
@property(nonatomic, strong)id userObject5;

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<GCEgoImageViewDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,strong) NSURL* imageURL;
@property(nonatomic,strong) UIImage* placeholderImage;
@property(nonatomic,weak) id<GCEgoImageViewDelegate> delegate;
@end

@protocol GCEgoImageViewDelegate<NSObject>
@optional
- (void)imageViewLoadedImage:(GCEgoImageView*)imageView;
- (void)imageViewFailedToLoadImage:(GCEgoImageView*)imageView error:(NSError*)error;
@end