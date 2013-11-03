//
//  GCBarButtonImageItem.h
//  GCKit
//
//  Created by Gustavo Cassab on 20/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GCBarButtonImageItem : UIBarButtonItem {
	UIButton *_aButton;
}

+(id)buttonWithTarget:(id)aTarget action:(SEL)anAction normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

-(void)setHidden:(BOOL)hidden;

@end
