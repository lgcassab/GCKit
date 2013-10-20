//
//  GCAnimation.h
//  GCKit
//
//  Created by Gustavo Cassab on 05/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import <QuartzCore/CALayer.h>

@interface GCAnimation : NSObject {

}
@property (nonatomic, readonly, assign) id target;

- (void)startWithTarget:(id)target;

@end
