//
//  UITableView+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//


@interface UITableView (GCKit) {
	
}

// The view that contains the "index" along the right side of the table.
@property (nonatomic, readonly) UIView * indexView;

// Grouped tables have a margin but plain tables don't.  This is useful in table cell
// layout calculations where you don't want to hard-code the table style.
@property (nonatomic, readonly) CGFloat tableCellMargin;

- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToFirstRow:(BOOL)animated;
- (void)scrollToLastRow:(BOOL)animated;
//- (void)scrollFirstResponderIntoView;
- (void)scrollToCellAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)scrollToCellAtSection:(NSUInteger)section row:(NSUInteger)row animated:(BOOL)animated;

- (void)touchRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

- (UITableViewCell *)selectedCell;

@end
