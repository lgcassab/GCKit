//
//  GCTableSection.h
//  GCKit
//
//  Created by Gustavo Cassab on 10/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "GCTableCell.h"
#import "GCTableCellLabel.h"
#import "GCTableCellLabelSubtitle.h"
#import "GCTableCellLabelSubtitleHorizontal1.h"
#import "GCTableCellLabelSubtitleHorizontal2.h"

#import "GCTableCellLabelHorizontal3Columns.h"
#import "GCTableCellLabelHorizontal4Columns.h"
#import "GCTableCellLabelHorizontal5Columns.h"
#import "GCTableCellLabelHorizontal6Columns.h"
#import "GCTableCellLabelHorizontalMultiColumns.h"

#import "GCTableCellSwitch.h"
#import "GCTableCellTextField.h"
#import "GCTableCellSegmentedControl.h"

@class GCTableController;

@interface GCTableSection : NSObject {
    
    NSMutableArray *arrayRows;
    
    NSString *headerTitle;
    UIView *headerView;
    CGFloat headerHeight;
    
    NSString *footerTitle;
    UIView *footerView;
    CGFloat footerHeight;
	
	id userObject;
}
@property(nonatomic, assign)GCTableController *tableController;
@property(nonatomic, assign)UITableView *tableView;

@property(nonatomic, retain)NSMutableArray *arrayRows;

@property(nonatomic, retain)NSString *headerTitle;
@property(nonatomic, retain)UIView *headerView;
@property(nonatomic, readwrite)CGFloat headerHeight;

@property(nonatomic, retain)NSString *footerTitle;
@property(nonatomic, retain)UIView *footerView;
@property(nonatomic, readwrite)CGFloat footerHeight;

@property(nonatomic, retain)id userObject;

+(id)section;
+(id)sectionWithHeaderTitle:(NSString *)_headerTitle;
+(id)sectionWithHeaderTitle:(NSString *)_headerTitle footerTitle:(NSString *)_footerTitle;

+(id)sectionWithHeaderView:(UIView *)_headerView;
+(id)sectionWithHeaderView:(UIView *)_headerView footerView:(UIView *)_footerView;

-(NSInteger)count;

-(void)addCell:(GCTableCell *)cell;

-(void)insertCell:(GCTableCell *)cell;
-(void)insertCell:(GCTableCell *)cell animation:(UITableViewRowAnimation)animation;
-(void)insertCell:(GCTableCell *)cell atIndex:(NSUInteger)index;
-(void)insertCell:(GCTableCell *)cell atIndex:(NSUInteger)index animation:(UITableViewRowAnimation)animation;

-(void)removeLastCell;
-(void)removeLastCellWithAnimation:(UITableViewRowAnimation)animation;
-(void)removeCellAtIndex:(NSUInteger)_index;
-(void)removeCellAtIndex:(NSUInteger)_index animated:(BOOL)_animated;
-(void)removeAllCells;
-(void)removeAllCellsAnimated:(BOOL)_animated;
-(void)removeAllCellsWithAnimation:(UITableViewRowAnimation)_animation;

-(GCTableCell *)cellAtIndex:(NSInteger)index;

@end
