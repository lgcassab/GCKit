//
//  GCTableCellBadgeView.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCTableCellBadgeView : UIView {
	UIColor *color;
	NSString *text;
	UIFont *font;
}
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;

@end
