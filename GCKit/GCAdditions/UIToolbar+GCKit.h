//
//  UIToolbar+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

@interface UIToolbar (GCKit) {
	
}

- (UIBarButtonItem *)itemWithTag:(NSInteger)tag;
- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item;

@end
