//
//  GCActionCallFunc.h
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"

@interface GCActionCallFunc : GCAction {
	
}

+ (id)actionWithTarget:(id)cfTarget selector:(SEL)selector;

@end
