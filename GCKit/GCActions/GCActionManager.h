//
//  GCActionManager.h
//  GCKit
//
//  Created by Gustavo Cassab on 20/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"
#import "GCActionMoveTo.h"
#import "GCActionMoveBy.h"
#import "GCActionRotateTo.h"
#import "GCActionRotateBy.h"
#import "GCActionFadeIn.h"
#import "GCActionFadeOut.h"
#import "GCActionScaleTo.h"
#import "GCActionScaleBy.h"
#import "GCActionSequence.h"
#import "GCActionDelay.h"
#import "GCActionCallFunc.h"

@interface GCActionManager : NSObject {

}
@property(nonatomic, strong)NSMutableArray *arrayActions;

+ (GCActionManager *)sharedManager;

- (void)addAction:(GCAction *)action target:(id)target;
- (void)removeActionWithTarget:(id)target;
- (void)removeAction:(id)action;

@end
