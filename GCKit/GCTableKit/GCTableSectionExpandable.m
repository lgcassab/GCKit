//
//  GCTableSectionExpandable.m
//  GCKit
//
//  Created by Gustavo Cassab on 15/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableSectionExpandable.h"
#import "GCTableController.h"
#import "UIView+GCKit.h"

@interface GCTableSectionExpandable (Private)
-(id)initWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle;
@end

@implementation GCTableSectionExpandable
@synthesize mainCell, arrayExpandable;

+(id)sectionWithMainCell:(GCTableCell *)_mainCell {
    return [[self alloc]initWithMainCell:_mainCell headerTitle:nil footerTitle:nil];
}

+(id)sectionWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle {
    return [[self alloc]initWithMainCell:_mainCell headerTitle:_headerTitle footerTitle:nil];
}

+(id)sectionWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle {
    return [[self alloc]initWithMainCell:_mainCell headerTitle:_headerTitle footerTitle:_footerTitle];
}

-(id)init {
	if( (self=[super init] )) {
        self.mainCell = nil;
	}
	return self;
}

-(id)initWithMainCell:(GCTableCell *)_mainCell headerTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle {
	
	if ((self=[self init] )) {
		self.headerTitle = _headerTitle;
		self.footerTitle = _footerTitle;
		
		self.mainCell = _mainCell;
		[mainCell setTableController:self.tableController];
		[mainCell setSelectionStyle:UITableViewCellSelectionStyleNone];
		[arrayRows addObject:mainCell];
		
		self.arrayExpandable = [NSMutableArray new];
		
		expanded = NO;
		_shouldRotateAccessoryView = NO;
	}
    
    
    
    return self;
}

#pragma mark - Add/Insert Cells

-(void)addCell:(GCTableCell *)cell {
	
	if (self.tableController != nil) {
        [cell setTableController:self.tableController];
    }
	
    [arrayExpandable addObject:cell];
}

-(void)insertCell:(GCTableCell *)cell atIndex:(NSUInteger)index {
	[super insertCell:cell atIndex:index];
	[arrayExpandable insertObject:cell atIndex:index-1];
}

#pragma mark - Remover Cells

-(void)removeCellAtIndex:(NSUInteger)_index animated:(BOOL)_animated {
	[arrayExpandable removeObjectAtIndex:_index-1];
	[super removeCellAtIndex:_index animated:_animated];
}

-(void)removeAllCells {
	[self removeAllCellsAnimated:NO];
}

-(void)removeAllCellsAnimated:(BOOL)_animated {
	
	while ([arrayExpandable count] > 0) { // era > 1
		GCTableCell *cell = [arrayExpandable objectAtIndex:0];
		if (cell != mainCell) {
			
			NSIndexPath *ip = [self.tableView indexPathForCell:cell];
			
			[arrayExpandable removeObject:cell];
			
			if ([arrayRows containsObject:cell])
				[arrayRows removeObject:cell];
			
			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationFade];
		}
	}
}

#pragma mark -
#pragma mark Expand/Tap control

-(BOOL)isExpanded {
	return expanded;
}

-(void)tap {
    [self sectionTapped];
}

-(void)sectionTapped {
    
    BOOL ex = expanded;
    
    NSUInteger sectionIndex = [self.tableController indexForSection:self];
    
    UIView *aView = mainCell.accessoryView;
    float rotateDelay = 0.25f;
    
    if (ex) { // Recolher celulas
        
        [arrayRows removeAllObjects];
        [arrayRows addObject:mainCell];
        
        NSMutableArray *tmpArrayIndexPath = [NSMutableArray array];
        for (int i=0; i < [arrayExpandable count]; i++ ) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i+1 inSection:sectionIndex];
            [tmpArrayIndexPath addObject:ip];
        }
        
        [self.tableView deleteRowsAtIndexPaths:tmpArrayIndexPath withRowAnimation:UITableViewRowAnimationFade];
        
        if (_shouldRotateAccessoryView)
            if (aView)
                [aView runAction:[GCActionRotateBy actionWithDuration:rotateDelay angle:180]];

    } else { // Mostrar celulas

        [arrayRows addObjectsFromArray:arrayExpandable];
        
        NSMutableArray *tmpArrayIndexPath = [NSMutableArray array];
        for (int i=0; i < [arrayExpandable count]; i++ ) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i+1 inSection:sectionIndex];
            [tmpArrayIndexPath addObject:ip];
        }
        
        [self.tableView insertRowsAtIndexPaths:tmpArrayIndexPath withRowAnimation:UITableViewRowAnimationFade];
        
        if (_shouldRotateAccessoryView)
            if (aView)
                [aView runAction:[GCActionRotateBy actionWithDuration:rotateDelay angle:-180]];
    }
    
    expanded = !ex;
    
    [self.tableController expandableSection:self hasBeenExpanded:expanded];
}

@end
