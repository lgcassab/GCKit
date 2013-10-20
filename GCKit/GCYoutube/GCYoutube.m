//
//  GCYoutube.m
//  Suvinil-Simulador-iPad
//
//  Created by Gustavo Cassab on 17/07/13.
//  Copyright (c) 2013 PorQueNão?. All rights reserved.
//

#import "GCYoutube.h"
#import "UIView+GCKit.h"
#import "NSString+GCKit.h"
#import "NSObject+GCKit.h"

@interface GCYoutube ( )
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@end

@implementation GCYoutube

- (id)initWithFrame:(CGRect)frame videoID:(NSString *)nVideoID {
    return [self initWithFrame:frame videoID:nVideoID autoplay:NO];
}

- (id)initWithFrame:(CGRect)frame videoID:(NSString *)nVideoID autoplay:(BOOL)autoplay {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViewWithVideoID:nVideoID autoplay:autoplay];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame videoUrl:(NSString *)nVideoURL {
    return [self initWithFrame:frame videoUrl:nVideoURL autoplay:NO];
}

- (id)initWithFrame:(CGRect)frame videoUrl:(NSString *)nVideoURL autoplay:(BOOL)autoplay {
    self = [super initWithFrame:frame];
    if (self) {
        NSString *videoID = [NSString substringWithString:nVideoURL between:@"?v=" and:@"&"];
        [self configureViewWithVideoID:videoID autoplay:autoplay];
    }
    return self;
}

- (void)configureViewWithVideoID:(NSString *)nVideoID autoplay:(BOOL)nAutoplay {
    [self setBackgroundColor:[UIColor blackColor]];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_webView setDelegate:self];
    [_webView setOpacity:NO];
    [_webView.scrollView setScrollEnabled:NO];
    [self addSubview:_webView];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_activityIndicator setCenter:self.center];
    [_activityIndicator setHidesWhenStopped:YES];
    [self addSubview:_activityIndicator];
    
    if (nAutoplay) {
        [self playYoutubeWithVideoID:nVideoID];
    } else {
        [self loadYoutubeWithVideoID:nVideoID];
    }
}

#pragma mark - Private Methods

- (void)playYoutubeWithVideoID:(NSString *)nVideoID {

    [_webView setMediaPlaybackRequiresUserAction:NO];
    
    NSString *fileName = [NSString stringWithFormat:@"youtubevideo%@.html", nVideoID];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory ,NSUserDomainMask, YES) objectAtIndex:0], fileName];
    
    NSString *htmlString = @"\
    <html>\
    <head>\
    <script src=\"https://www.youtube.com/player_api\"></script>\
    <style>\
    body, div {\
    margin: 0px;\
    padding: 0px;\
    }\
    </style>\
    </head>\
    <body>\
    <div id=\"media_area\"></div>\
    </body>\
    <script>\
    var ytPlayer = null;\
    \
    function onYouTubePlayerAPIReady() {\
    ytPlayer = new YT.Player('media_area', {height: '%f', width: '%f', videoId: '%@',\
    playerVars: {'showinfo': 0},\
    events: {'onReady': onPlayerReady}\
    });\
    }\
    \
    function onPlayerReady(e) {\
    e.target.playVideo();\
    }\
    </script>\
    </html>";
    
    NSString *html = [NSString stringWithFormat:htmlString, self.height, self.width, nVideoID];
    
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    [data writeToFile:filePath atomically:YES];
    
	for (id subview in [self subviews]) {
		if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
			((UIScrollView *)subview).scrollEnabled = NO;
		}
		if ([[subview class] isSubclassOfClass: [UIView class]]) {
			((UIView *)subview).backgroundColor = [UIColor clearColor];
		}
	}
	
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: filePath]]];
}

- (void)loadYoutubeWithVideoID:(NSString *)nVideoID {
    
    NSString *fileName = [NSString stringWithFormat:@"youtubevideo%@.html", nVideoID];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory ,NSUserDomainMask, YES) objectAtIndex:0], fileName];
    
    NSString *htmlString = @"\
    <html>\
    <head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = \"%f\"/>\
    </head>\
    <body style=\"background:#000000;margin-top:0px;margin-left:0px\">\
    <iframe width= \"%f\" height=\"%f\" src = \"http://www.youtube.com/embed/%@?showinfo=0\" frameborder=\"0\" allowfullscreen>\
    </iframe></div>\
    </body>\
    </html>";
    NSString *html = [NSString stringWithFormat:htmlString, self.width, self.width, self.height, nVideoID];    
    
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    [data writeToFile:filePath atomically:YES];
    
	for (id subview in [self subviews]) {
		if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
			((UIScrollView *)subview).scrollEnabled = NO;
		}
		if ([[subview class] isSubclassOfClass: [UIView class]]) {
			((UIView *)subview).backgroundColor = [UIColor clearColor];
		}
	}
	
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: filePath]]];
}

#pragma mark - Public Methods

- (void)stopLoading {
    [_webView stopLoading];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [webView setOpacity:NO];
    [_activityIndicator startAnimating];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(gcYoutubeDidStartLoading:)]) {
            [_delegate gcYoutubeDidStartLoading:self];
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_activityIndicator stopAnimating];
    [_activityIndicator removeFromSuperview];
    
    [self performBlock:^{
        [webView setOpacity:YES];
    } afterDelay:0.50f];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(gcYoutubeDidFinishLoad:)]) {
            [_delegate gcYoutubeDidFinishLoad:self];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [_activityIndicator stopAnimating];
    [_activityIndicator removeFromSuperview];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(gcYoutube:didFailLoadWithError:)]) {
            [_delegate gcYoutube:self didFailLoadWithError:error];
        }
    }
}

@end
