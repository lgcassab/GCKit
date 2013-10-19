//
//  UIImageView+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 29/07/12.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "UIImageView+GCKit.h"

@implementation UIImageView (GCKit)

+ (UIImageView *)imageViewWithImageNamed:(NSString *)imageName {
    return [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
}

@end
