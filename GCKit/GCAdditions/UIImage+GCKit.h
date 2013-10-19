//
//  UIImage+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

@interface UIImage (GCKit) {
	
}

/*
 * Resizes an image. Optionally rotates the image based on imageOrientation.
 */
- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

/**
 * Returns a CGRect positioned within rect given the contentMode.
 */
- (CGRect)convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image using content mode rules.
 */
- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image as a rounded rectangle.
 */
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius;
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode;

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

-(UIImage*)maskWithImage:(UIImage*)mask;
-(UIColor *)colorFromPixelAtPosition:(CGPoint )position;

// Resize

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

// Rounded Corner

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

// Aplha

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

// Aumentar a largura de uma imagem, replicando uma parte interna do lado esquerdo e direito, preservando as laterais e o interior. Ideal para aumentar a largura de balões.
- (UIImage *)strechImageToWidth:(NSUInteger)width
           replicatingLeftXFrom:(CGFloat)leftXFrom
                        leftXTo:(CGFloat)leftXTo
                     rightXFrom:(CGFloat)rightXFrom
                       rightXTo:(CGFloat)rightXTo;

@end
