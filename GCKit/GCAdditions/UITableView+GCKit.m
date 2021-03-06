//
//  UITableView+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "UITableView+GCKit.h"
#import "UIWindow+GCKit.h"

@implementation UITableView (GCKit)

- (UIView *)indexView {
	
	Class indexViewClass = NSClassFromString(@"UITableViewIndex");
	NSEnumerator *e = [self.subviews reverseObjectEnumerator];
	
	for (UIView *child; child = [e nextObject]; ) {
		if ([child isKindOfClass:indexViewClass]) {
			return child;
		}
	}
	
	return nil;
}

- (CGFloat)tableCellMargin {
	if (self.style == UITableViewStyleGrouped) {
		return 10;
	} else {
		return 0;
	}
}

- (void)scrollToTop:(BOOL)animated {
	[self setContentOffset:CGPointMake(0,0) animated:animated];
}

- (void)scrollToBottom:(BOOL)animated {
	
	NSUInteger sectionCount = [self numberOfSections];
	
	if (sectionCount) {
		NSUInteger rowCount = [self numberOfRowsInSection:0];
		
		if (rowCount) {
			NSUInteger ii[2] = {0, rowCount-1};
			NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
			
			[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
		}
	}
}

- (void)scrollToFirstRow:(BOOL)animated {
	
	if ([self numberOfSections] > 0 && [self numberOfRowsInSection:0] > 0) {
		NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
	}
}

- (void)scrollToLastRow:(BOOL)animated {
	
	if ([self numberOfSections] > 0) {
		
		NSInteger section = [self numberOfSections]-1;
		NSInteger rowCount = [self numberOfRowsInSection:section];
		
		if (rowCount > 0) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowCount-1 inSection:section];
			[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
		}
	}
}

// TODO: [Cassab] DESCOMENTAR DEPOIS QUE ADICIONAR UIView+GCKit

//- (void)scrollFirstResponderIntoView {
//	
//	UIView *responder = [self.window findFirstResponder];
//	UITableViewCell *cell = (UITableViewCell *)[responder ancestorOrSelfWithClass:[UITableViewCell class]];
//	if (cell) {
//		NSIndexPath *indexPath = [self indexPathForCell:cell];
//		if (indexPath) {
//			[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//		}
//	}
//}

- (void)scrollToCellAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    UITableView *table = (UITableView *)self;
    [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)scrollToCellAtSection:(NSUInteger)section row:(NSUInteger)row animated:(BOOL)animated {
    UITableView *table = (UITableView *)self;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)touchRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	
	if (![self cellForRowAtIndexPath:indexPath]) {
		
		[self reloadData];
		
		if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
			[self.delegate tableView:self willSelectRowAtIndexPath:indexPath];
		}
		
		[self selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionTop];
		
		if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
			[self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
		}
	}
}

-(UITableViewCell *)selectedCell {
    NSIndexPath *indexPath = [self indexPathForSelectedRow];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    return cell;
}

@end
