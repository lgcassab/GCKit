//
//  GCYoutube.h
//  Suvinil-Simulador-iPad
//
//  Created by Gustavo Cassab on 17/07/13.
//  Copyright (c) 2013 PorQueNão?. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCYoutube : UIView <UIWebViewDelegate> {
    
}
@property (nonatomic, assign) id delegate;

- (id)initWithFrame:(CGRect)frame videoID:(NSString *)nVideoID;
- (id)initWithFrame:(CGRect)frame videoID:(NSString *)nVideoID autoplay:(BOOL)autoplay;
- (id)initWithFrame:(CGRect)frame videoUrl:(NSString *)nVideoURL;
- (id)initWithFrame:(CGRect)frame videoUrl:(NSString *)nVideoURL autoplay:(BOOL)autoplay;

- (void)stopLoading;

@end

@protocol GCYoutubeDelegate <NSObject>
@optional
- (void)gcYoutubeDidStartLoading:(GCYoutube *)gcYoutube;
- (void)gcYoutubeDidFinishLoad:(GCYoutube *)gcYoutube;
- (void)gcYoutube:(GCYoutube *)gcYoutube didFailLoadWithError:(NSError *)error;
@end
