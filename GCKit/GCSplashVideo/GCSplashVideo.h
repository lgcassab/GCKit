//
//  GCSplashVideo.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/04/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>

typedef void (^CompletitionBlock)();

@interface GCSplashVideo : UIViewController {

}
@property (nonatomic, strong) MPMoviePlayerViewController *playerViewController;

+ (GCSplashVideo *)presentVideo:(NSString *)video ofType:(NSString *)type completitionBlock:(CompletitionBlock)completitionBlock;
- (GCSplashVideo *)initWithVideo:(NSString *)video ofType:(NSString *)type completitionBlock:(CompletitionBlock)completitionBlock;

@end
