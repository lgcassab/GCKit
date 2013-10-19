//
//  UITextView+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 16/07/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import "UITextView+GCKit.h"

@implementation UITextView (GCKit)

- (NSUInteger)numberOfLines {
    NSArray *lines = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return ([lines count]);
}

- (CGFloat)lineHeight {
    return self.font.lineHeight;
}

@end
