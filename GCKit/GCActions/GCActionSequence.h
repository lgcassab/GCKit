//
//  GCActionSequence.h
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"

@interface GCActionSequence : GCAction {
	
}
@property (nonatomic, strong) NSMutableArray *arrayActions;

+ (id)actions:(GCAction *)action1, ... NS_REQUIRES_NIL_TERMINATION;
- (void)lastActionFinished;

@end
