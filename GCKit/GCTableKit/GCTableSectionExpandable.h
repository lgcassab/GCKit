//
//  GCTableSectionExpandable.h
//  GCKit
//
//  Created by Gustavo Cassab on 15/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableSection.h"

@class GCTableCell;

@interface GCTableSectionExpandable : GCTableSection {
    GCTableCell *mainCell;
    NSMutableArray *arrayExpandable;
    BOOL expanded;
}
@property(nonatomic, retain)GCTableCell *mainCell;
@property(nonatomic, retain)NSMutableArray *arrayExpandable;
@property(nonatomic, readwrite) BOOL shouldRotateAccessoryView;

+(id)sectionWithMainCell:(GCTableCell *)_mainCell;

+(id)sectionWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle;
+(id)sectionWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle;

-(void)sectionTapped;
-(void)tap;

-(BOOL)isExpanded;

@end
