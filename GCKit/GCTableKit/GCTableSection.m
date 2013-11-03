//
//  GCTableSection.m
//  GCKit
//
//  Created by Gustavo Cassab on 10/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableSection.h"
#import "GCTableController.h"

@interface GCTableSection (Private)

#define _defaultHeight 22.0f

-(id)initWithHeaderTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle;

@end

@implementation GCTableSection
@synthesize tableController, tableView;
@synthesize arrayRows;
@synthesize headerTitle, headerView, headerHeight;
@synthesize footerTitle, footerView, footerHeight;
@synthesize userObject;

+(id)section {
    return [[self alloc]initWithHeaderTitle:nil footerTitle:nil];
}

+(id)sectionWithHeaderTitle:(NSString *)_headerTitle {
    return [[self alloc]initWithHeaderTitle:_headerTitle footerTitle:nil];
}

+(id)sectionWithHeaderTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle {
    return [[self alloc]initWithHeaderTitle:_headerTitle footerTitle:_footerTitle];
}

+(id)sectionWithHeaderView:(UIView *)_headerView {
    GCTableSection *section = [[GCTableSection alloc]init];
    [section setHeaderView:_headerView];
    [section setHeaderHeight:_headerView.frame.size.height];
    return section;
}

+(id)sectionWithHeaderView:(UIView *)_headerView footerView:(UIView *)_footerView {
    GCTableSection *section = [[GCTableSection alloc]init];
    [section setHeaderView:_headerView];
    [section setHeaderHeight:_headerView.frame.size.height];
    [section setFooterView:_footerView];
    [section setFooterHeight:_footerView.frame.size.height];
    return section;
}

-(id)initWithHeaderTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle {
    
	if( (self=[self init] )) {
		self.headerTitle = _headerTitle;
		self.footerTitle = _footerTitle;
		
		if (headerTitle != nil) {
			self.headerHeight = _defaultHeight;
		}
		
		if (footerTitle != nil) {
			self.footerHeight = _defaultHeight;
		}
	}
    
    return  self;
}

-(id)init {
	
	if( (self=[super init] )) {
        
        self.tableController = nil;
        self.tableView = nil;
        
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
            self.arrayRows = tmpArray;
        }
        
        self.headerTitle = nil;
        self.headerView = nil;
        self.headerHeight = 0;
        
        self.footerTitle = nil;
        self.footerView = nil;
        self.footerHeight = 0;
	}
	
	return self;
}

-(NSInteger)count {
    return [arrayRows count];
}

#pragma mark -
#pragma mark Add/Insert Cells

-(void)addCell:(GCTableCell *)cell {
    
    if (self.tableController != nil) {
        [cell setTableController:self.tableController];
    }
    
    [arrayRows addObject:cell];  
}

-(void)insertCell:(GCTableCell *)cell {
    [self insertCell:cell animation:UITableViewRowAnimationFade];
}

-(void)insertCell:(GCTableCell *)cell animation:(UITableViewRowAnimation)animation {
    
    [cell setTableController:self.tableController];
    [arrayRows addObject:cell];  
    
    NSUInteger sec = [tableController indexForSection:self];
    
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:([arrayRows count]-1) inSection:sec]]
                     withRowAnimation:animation];
}

-(void)insertCell:(GCTableCell *)cell atIndex:(NSUInteger)index {
    [self insertCell:cell atIndex:index animation:UITableViewRowAnimationFade];
}

-(void)insertCell:(GCTableCell *)cell atIndex:(NSUInteger)index animation:(UITableViewRowAnimation)animation {

    [cell setTableController:self.tableController];
    [arrayRows insertObject:cell atIndex:index];
    
    NSUInteger sec = [tableController indexForSection:self];
    
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:sec]]
                     withRowAnimation:animation];
}

#pragma mark -
#pragma mark Remove Cells

-(void)removeLastCell {
    
    if ([arrayRows count] <= 0)
        return;
    
    [self removeLastCellWithAnimation:UITableViewRowAnimationFade];   
}

-(void)removeLastCellWithAnimation:(UITableViewRowAnimation)animation {
    
    if ([arrayRows count] <= 0)
        return;
    
    [arrayRows removeLastObject];
    NSUInteger sec = [tableController indexForSection:self];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[arrayRows count] inSection:sec] ]
                                              withRowAnimation:animation];
}

-(void)removeCellAtIndex:(NSUInteger)_index {
    
    if ([arrayRows count] <= 0)
        return;
    
    [self removeCellAtIndex:_index animated:NO];
}

-(void)removeCellAtIndex:(NSUInteger)_index animated:(BOOL)_animated {
    
    if ([arrayRows count] <= 0)
        return;
    
    [arrayRows removeObjectAtIndex:_index];
    NSUInteger sec = [tableController indexForSection:self];

    if (_animated)
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_index inSection:sec] ]
                         withRowAnimation:UITableViewRowAnimationFade];
    else 
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_index inSection:sec] ]
                         withRowAnimation:UITableViewRowAnimationNone];
}

-(void)removeAllCells {
    
    if ([arrayRows count] <= 0)
        return;
    
    [self removeAllCellsAnimated:NO];
}

-(void)removeAllCellsAnimated:(BOOL)_animated {
    
    if ([arrayRows count] <= 0)
        return;
    
    if (_animated)
        [self removeAllCellsWithAnimation:UITableViewRowAnimationFade];
    else
        [self removeAllCellsWithAnimation:UITableViewRowAnimationNone];
}

-(void)removeAllCellsWithAnimation:(UITableViewRowAnimation)_animation {
    
    if ([arrayRows count] <= 0)
        return;
    
    NSUInteger section = [tableController indexForSection:self];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];

    for (int i=0; i < [arrayRows count]; i++ ) {
        [tmpArray addObject:[NSIndexPath indexPathForRow:i inSection:section] ];
    }
    
    [arrayRows removeAllObjects];
    
    [tableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:_animation];
    
    [tmpArray removeAllObjects];
}

#pragma mark -
#pragma mark Retrieve Cells

-(GCTableCell *)cellAtIndex:(NSInteger)index {
    return (GCTableCell *)[arrayRows objectAtIndex:index];
}

@end
