//
//  GCCustomColoredAccessory.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCCustomColoredAccessory : UIControl {
    UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (GCCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;
+ (GCCustomColoredAccessory *)accessoryWithColor:(UIColor *)color highlightedColor:(UIColor *)newHighlightedColor;

@end
