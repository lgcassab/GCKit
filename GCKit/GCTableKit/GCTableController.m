//
//  GCTableController.m
//  GCKit
//
//  Created by Gustavo Cassab on 10/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableController.h"

@interface GCTableController (Private)
- (void)filterContentForSearchText:(NSString*)_searchText scope:(NSString*)scope;
@end

@implementation GCTableController
@synthesize  delegate;
@synthesize tableView;
@synthesize arraySections;
@synthesize dictionaryKeyValues;

@synthesize searchDisplayController, searchActive, searchText, arrayFilter;
@synthesize searchField;
@synthesize showIndexABC;

-(id)initWithTableView:(UITableView *)_tableView delegate:(id)_delegate {
	return [self initWithTableView:_tableView delegate:_delegate searchField:gcTableControllerSearchFieldTextLabel];
}

-(id)initWithTableView:(UITableView *)_tableView delegate:(id)_delegate searchField:(GCTableControllerSearchField)gcTableControllerSearchField {
    
    if( (self=[super init] )) {
        { 
            NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
            self.arraySections = tmpArray;
        }
        
        {
            NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc]init];
            self.dictionaryKeyValues = tmpDict;
        }
        
        self.delegate = _delegate;
		
		self.tableView = _tableView;
		[tableView setDelegate:self];
        [tableView setDataSource:self];
        
        self.searchDisplayController = nil;
		
		self.searchActive = NO;
        self.searchText = nil;
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
            self.arrayFilter = tmpArray;
        }
        
        [self setSearchField:gcTableControllerSearchField];
        
        showIndexABC = NO;
    }
    
    return self;
}

-(void)reloadData {
    [self.tableView reloadData];
}

-(NSUInteger)indexForSection:(GCTableSection *)section {
    return [arraySections indexOfObject:section];
}

-(NSIndexPath *)indexPathForCell:(GCTableCell *)cell {
    return [tableView indexPathForCell:cell];
}

-(id)valueForDictionaryKey:(NSString *)key {
    return [dictionaryKeyValues valueForKey:key];
}

-(void)setValue:(id)value toInternalDictionaryKey:(NSString *)key {
    [dictionaryKeyValues setValue:value forKey:key];
}

-(NSUInteger)count {
	NSUInteger ret = 0;
	
	for (GCTableSection *section in arraySections) {
		if (section)
			ret += [section count];
	}
	
	return ret;
}

-(GCTableCell *)selectedCell {
	NSIndexPath *ip = [tableView indexPathForSelectedRow];
	return (GCTableCell *)[tableView cellForRowAtIndexPath:ip];
}

-(void)deleteCell:(GCTableCell *)_cell {
	NSIndexPath *ip = [tableView indexPathForCell:_cell];
	GCTableSection *s = [arraySections objectAtIndex:ip.section];
	[s removeCellAtIndex:ip.row animated:YES];
	
	if ([s count] <= 0) {
		[self deleteSection:s];
	}
}

#pragma mark -
#pragma mark Sections - add

-(void)addSection:(GCTableSection *)_section {
    [_section setTableController:self];
    [_section setTableView:self.tableView];
    
    if ([delegate respondsToSelector:@selector(tableViewControlled:willConfigureSection:atIndex:)])
        [delegate tableViewControlled:self.tableView willConfigureSection:_section atIndex:[self indexForSection:_section] ];
    
    [arraySections addObject:_section];
    
    for (GCTableCell *cell in _section.arrayRows) {
        [cell setTableController:self];
    }

}

#pragma mark -
#pragma mark Sections - insert

-(void)insertSection:(GCTableSection *)_section {
	int c = [arraySections count];
	if (c < 0) c = 0;
	if (c >= 1) c--;
    [self insertSection:_section atIndex:c animated:NO];
}

-(void)insertSection:(GCTableSection *)_section withRowAnimation:(UITableViewRowAnimation)_rowAnimation {
	[self insertSection:_section atIndex:([arraySections count]-1) withRowAnimation:_rowAnimation];
}

-(void)insertSection:(GCTableSection *)_section animated:(BOOL)_animated {
    
    int count = ([arraySections count]-1);
    if (count < 0)
        count = 0;
    
    if (_animated)
        [self insertSection:_section atIndex:count withRowAnimation:UITableViewRowAnimationFade];
    else
        [self insertSection:_section atIndex:count withRowAnimation:UITableViewRowAnimationNone];
}

-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index {
    [self insertSection:_section atIndex:_index withRowAnimation:UITableViewRowAnimationNone];
}

-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index animated:(BOOL)_animated {
    if (_animated)
        [self insertSection:_section atIndex:_index withRowAnimation:UITableViewRowAnimationFade];
    else 
        [self insertSection:_section atIndex:_index withRowAnimation:UITableViewRowAnimationNone];
}

-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index withRowAnimation:(UITableViewRowAnimation)_rowAnimation {
    [_section setTableController:self];
    [_section setTableView:self.tableView];
    
    if ([delegate respondsToSelector:@selector(tableViewControlled:willConfigureSection:atIndex:)])
        [delegate tableViewControlled:self.tableView willConfigureSection:_section atIndex:[self indexForSection:_section] ];
    
    [arraySections insertObject:_section atIndex:_index];
    
    [tableView beginUpdates];
    [tableView insertSections:[NSIndexSet indexSetWithIndex:_index ] withRowAnimation:_rowAnimation];
    [tableView endUpdates];
    
    for (GCTableCell *cell in _section.arrayRows) {
        [cell setTableController:self];
    }
}

#pragma mark -
#pragma mark Sections - delete

-(void)deleteAllSections {
    [self deleteAllSectionsAnimated:NO];
}

-(void)deleteAllSectionsAnimated:(BOOL)_animated {

    if (_animated) {
        
        while ([arraySections count] > 0) {
            GCTableSection *section = [arraySections objectAtIndex:0];
            [self deleteSection:section withRowAnimation:UITableViewRowAnimationFade];
        }
        
    } else {
        
        if ([arraySections count] > 0) {
            [arraySections removeAllObjects];
            [tableView reloadData];
        }
    }
}

-(void)deleteSection:(GCTableSection *)_section {
    [self deleteSection:_section animated:NO];
}

-(void)deleteSection:(GCTableSection *)_section animated:(BOOL)_animated {
    if (_animated)
        [self deleteSection:_section withRowAnimation:UITableViewRowAnimationFade];
    else
        [self deleteSection:_section withRowAnimation:UITableViewRowAnimationNone];
}

-(void)deleteSectionAtIndex:(NSUInteger)_index {
    [self deleteSectionAtIndex:_index animated:NO];
}

-(void)deleteSectionAtIndex:(NSUInteger)_index animated:(BOOL)_animated {
    GCTableSection *section = [arraySections objectAtIndex:_index];
    
    if (_animated)
        [self deleteSection:section withRowAnimation:UITableViewRowAnimationFade];
    else
        [self deleteSection:section withRowAnimation:UITableViewRowAnimationNone];
}

-(void)deleteSectionAtIndex:(NSUInteger)_index withRowAnimation:(UITableViewRowAnimation)_rowAnimation {
    GCTableSection *section = [arraySections objectAtIndex:_index];
    [self deleteSection:section withRowAnimation:_rowAnimation];
}

-(void)deleteSection:(GCTableSection *)_section withRowAnimation:(UITableViewRowAnimation)_rowAnimation {
    [self deleteSection:_section withRowAnimation:_rowAnimation removingCells:NO];
}

-(void)deleteSection:(GCTableSection *)_section withRowAnimation:(UITableViewRowAnimation)_rowAnimation removingCells:(BOOL)removingCells {
    
    if (removingCells) {
        [_section removeAllCellsWithAnimation:_rowAnimation];
    }
    
    NSUInteger index = [arraySections indexOfObject:_section];
    
    [arraySections removeObject:_section];
    
    [tableView beginUpdates];
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:_rowAnimation];
    [tableView endUpdates];
}

#pragma mark - ExpandableSection

-(void)expandableSection:(GCTableSectionExpandable *)section hasBeenExpanded:(BOOL)expanded {
    if ([delegate respondsToSelector:@selector(tableViewControlled:expandableSection:hasBeenExpanded:)]) {
        [delegate tableViewControlled:self.tableView expandableSection:section hasBeenExpanded:expanded];
    }
}

#pragma mark - Public Methods

-(void)scrollToCell:(GCTableCell *)cell atScrollPosition:(UITableViewScrollPosition )scrollPosition {
    [tableView scrollToRowAtIndexPath:[self indexPathForCell:cell] atScrollPosition:scrollPosition animated:YES];
}

-(UIScrollView *)scrollView {
    UIScrollView *sv = nil;
    
    for (id sub in [tableView subviews]) {
        if ([sub isKindOfClass:[UIScrollView class]]) {
            sv = sub;
            break;
        }
    }
    
    return sv;
}

#pragma mark -
#pragma mark TableView - Delegate Methods 
#pragma mark -

#pragma mark sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView {
	
	if (self.searchActive)
        return 1;
	
    return [arraySections count];
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section {
	
	if (self.searchActive && (self.searchText != nil)) {
        return [arrayFilter count];
    }
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] count];
}

#pragma mark Header

- (NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
	
	if (self.searchActive)
        return nil;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] headerTitle];
}

- (UIView *)tableView:(UITableView *)_tableView viewForHeaderInSection:(NSInteger)section {
	
	if (self.searchActive)
        return nil;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] headerView];
}

- (CGFloat)tableView:(UITableView *)_tableView heightForHeaderInSection:(NSInteger)section {
	
	if (self.searchActive)
        return 0;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] headerHeight];
}

#pragma mark Footer

- (NSString *)tableView:(UITableView *)_tableView titleForFooterInSection:(NSInteger)section {
	
	if (self.searchActive)
        return nil;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] footerTitle];
}

- (UIView *)tableView:(UITableView *)_tableView viewForFooterInSection:(NSInteger)section {
	
	if (self.searchActive)
        return nil;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] footerView];
}

- (CGFloat)tableView:(UITableView *)_tableView heightForFooterInSection:(NSInteger)section {
	
	if (self.searchActive)
        return 0;
	
    return [(GCTableSection *)[arraySections objectAtIndex:section] footerHeight];
}

#pragma mark Rows 

- (void)tableView:(UITableView *)_tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if ([delegate conformsToProtocol:@protocol(GCTableControllerDelegate)]) {
        if ([delegate respondsToSelector:@selector(tableViewControlled:willConfigureCell:forRowAtIndexPath:)]) {
			
			if (self.searchActive) {
				GCTableCell *cell = (GCTableCell *)[arrayFilter objectAtIndex:indexPath.row];
				[delegate tableViewControlled:_tableView willConfigureCell:cell forRowAtIndexPath:indexPath];
			} else {
				GCTableSection *section = [arraySections objectAtIndex:indexPath.section];
				GCTableCell *cell = (GCTableCell *)[section cellAtIndex:indexPath.row];
				[delegate tableViewControlled:_tableView willConfigureCell:cell forRowAtIndexPath:indexPath];
			}
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (self.searchActive)
        return (GCTableCell *)[arrayFilter objectAtIndex:indexPath.row];
    
    GCTableCell *cell = [(GCTableSection *)[self.arraySections objectAtIndex:indexPath.section]cellAtIndex:indexPath.row];
    if (cell.indexPath == nil) {
        [cell setIndexPath:indexPath];
    }
	
    return cell;
	
//    return [(GCTableSection *)[arraySections objectAtIndex:indexPath.section]cellAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (self.searchActive)
        return 44; //[(GCTableCell *)[arrayFilter objectAtIndex:indexPath.row]height];
	
    return [(GCTableCell *)[(GCTableSection *)[arraySections objectAtIndex:indexPath.section]cellAtIndex:indexPath.row] height];
}

#pragma mark -
#pragma mark Selection

- (void)tableView:(UITableView *)_tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:accessoryButtonTappedForRowWithIndexPath:cell:)]) {
        [delegate tableViewControlled:_tableView accessoryButtonTappedForRowWithIndexPath:indexPath cell:(GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath] ];
    }
}

- (NSIndexPath *)tableView:(UITableView *)_tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([(GCTableCell *)[self.tableView cellForRowAtIndexPath:indexPath] lockCellSelection])
		return nil;
    
    if ([[arraySections objectAtIndex:indexPath.section] isKindOfClass:[GCTableSectionExpandable class]]) {
        if (indexPath.row == 0) {
            [(GCTableSectionExpandable *)[arraySections objectAtIndex:indexPath.section] sectionTapped];
            return  nil;
        }
    }
    
    if ([delegate respondsToSelector:@selector(tableViewControlled:willSelectRowAtIndexPath:)]) {
        NSIndexPath *newIP = [delegate tableViewControlled:_tableView willSelectRowAtIndexPath:indexPath];
        return newIP;
    }
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)_tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:willDeselectRowAtIndexPath:)]) {
        NSIndexPath *newIP = [delegate tableViewControlled:_tableView willDeselectRowAtIndexPath:indexPath];
        return newIP;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:didSelectRowAtIndexPath:cell:)]) {
        [delegate tableViewControlled:_tableView didSelectRowAtIndexPath:indexPath cell:(GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath] ];
    }
}

- (void)tableView:(UITableView *)_tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:didDeselectRowAtIndexPath:cell:)]) {
        [delegate tableViewControlled:_tableView didDeselectRowAtIndexPath:indexPath cell:(GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath] ];
    }
}

#pragma mark -
#pragma mark Edit/Move/Delete

- (BOOL)tableView:(UITableView *)_tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	GCTableCell *cell = (GCTableCell *)[(GCTableSection *)[arraySections objectAtIndex:indexPath.section]cellAtIndex:indexPath.row];
	//	GCTableCell *cell = (GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath];
	return cell.canEdit;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)_tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath; {
	GCTableCell *cell = (GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath];
	return cell.editingStyle;
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	GCTableCell *cell = (GCTableCell *)[_tableView cellForRowAtIndexPath:indexPath];
	if ([delegate respondsToSelector:@selector(tableViewControlled:commitEditingStyle:forRowAtIndexPath:cell:)]) {
		[delegate tableViewControlled:_tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath cell:cell];
	}
}


//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark -
#pragma mark UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)_tableView {
    
    if (self.searchActive)
        return nil;
    
    if (showIndexABC) {
        NSMutableArray *arraySectionIndex = [[NSMutableArray alloc]init];
        for(char c = 'A';c<='Z';c++) {
            [arraySectionIndex addObject:[NSString stringWithFormat:@"%c",c]];
        }
        return arraySectionIndex;
    }
    
    if ([delegate respondsToSelector:@selector(sectionIndexTitlesForTableViewControlled:)]) {
        return [delegate sectionIndexTitlesForTableViewControlled:self.tableView];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)_tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {

    NSUInteger ret = -1;
    
    if ([delegate respondsToSelector:@selector(tableViewControlled:sectionForSectionIndexTitle:atIndex:)]) {
        ret = [delegate tableViewControlled:self.tableView sectionForSectionIndexTitle:title atIndex:index];
    } else {
        if ([arraySections count] == 1) {
            // Existe apenas 1 sessão, procura pelos textLabel de cada célula.
            GCTableSection *section = [arraySections lastObject];
            int countRow = -1;
            for (GCTableCell *cell in [section arrayRows]) {
                countRow++;
                if ([[[[[cell textLabel] text] substringToIndex:1]uppercaseString] isEqualToString:[title uppercaseString]]) {
                    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:countRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    break;
                }
            }
        } else {
            // Existem várias sessões. Procura pelo nome de cada sessão.
            int countSection = -1;
            for (GCTableSection *section in arraySections) {
                countSection++;
                if ([[[[section headerTitle] substringToIndex:1]uppercaseString]isEqualToString:[title uppercaseString]]) {
                    ret = countSection;
                    break;
                }
            }
        }
    }
    
    return ret;
}

#pragma mark -
#pragma mark UITableViewDelegate

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               

//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark -
#pragma mark Internal


-(void)valueChangedForCell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath object:(id)object {
    if ([delegate respondsToSelector:@selector(tableViewControlled:valueChangedForCell:indexPath:object:)]) {
        [delegate tableViewControlled:self.tableView valueChangedForCell:cell indexPath:indexPath object:object];
    }
}

#pragma mark -
#pragma mark UISearchDisplay
#pragma mark -

#pragma mark internal

-(void)setSearchBar:(UISearchBar *)searchBar {
    [self setSearchBar:searchBar searchField:gcTableControllerSearchFieldTextLabel];
}

-(void)setSearchBar:(UISearchBar *)searchBar searchField:(GCTableControllerSearchField)gcTableControllerSearchField {
    
    [self setSearchField:gcTableControllerSearchField];
    
    if (!searchDisplayController) {
        UISearchDisplayController *tmpController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self.delegate];                
        [tmpController setDelegate:self];
        [tmpController setSearchResultsDataSource:self];
        [tmpController setSearchResultsDelegate:self];
        self.searchDisplayController = tmpController;
    }
}

#pragma mark UISearchDisplayController Delegate Methods

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
    { // Para deixar o TableView da SearchController igual ao tableView original.
        [[controller searchResultsTableView]setBackgroundColor:self.tableView.backgroundColor];
        [[controller searchResultsTableView]setBackgroundView:self.tableView.backgroundView];        
        [[controller searchResultsTableView]setSeparatorColor:self.tableView.separatorColor];
        [[controller searchResultsTableView]setSeparatorStyle:self.tableView.separatorStyle];        
        [[controller searchResultsTableView]setRowHeight:self.tableView.rowHeight];                
    }
    
	if ([delegate respondsToSelector:@selector(tableViewControlled:willBeginSearch:)]) {
		[delegate tableViewControlled:self.tableView willBeginSearch:searchDisplayController];
	}
	
}

- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
	
    [controller setSearchResultsDelegate:self];
    self.searchActive = YES;
	
	if ([delegate respondsToSelector:@selector(tableViewControlled:didBeginSearch:)]) {
		[delegate tableViewControlled:self.tableView didBeginSearch:searchDisplayController];
	}
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
	if ([delegate respondsToSelector:@selector(tableViewControlled:willEndSearch:)]) {
		[delegate tableViewControlled:self.tableView willEndSearch:searchDisplayController];
	}
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {

    self.searchActive = NO;
	[self reloadData];
	
	if ([delegate respondsToSelector:@selector(tableViewControlled:didEndSearch:)]) {
		[delegate tableViewControlled:self.tableView didEndSearch:searchDisplayController];
	}
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] 
                                      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {

    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] 
                                      objectAtIndex:searchOption]];
    return YES;
}

#pragma mark Filter Content 

- (void)filterContentForSearchText:(NSString*)_searchText scope:(NSString*)scope {
	
    [self.arrayFilter removeAllObjects]; 
    self.searchText = _searchText;
    
    for (GCTableSection *section in arraySections) {
        for (GCTableCell *cell in section.arrayRows) {
			
//            NSComparisonResult result = [cell.textLabel.text compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
//            if (result == NSOrderedSame) {
//                [arrayFilter addObject:cell];
//            }
            
            NSString *stringSearch;
            
            if (searchField == gcTableControllerSearchFieldTextLabel) {
                stringSearch = cell.textLabel.text;
            } else {
                stringSearch = cell.detailTextLabel.text;
            }
			
//			NSRange titleResultsRange = [cell.textLabel.text rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch/*|NSAnchoredSearch*/) ];			
			NSRange titleResultsRange = [stringSearch rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch/*|NSAnchoredSearch*/) ];			            
			if (titleResultsRange.length > 0) {
				[arrayFilter addObject:cell];
			}
			
        }
    }

    if (self.searchDisplayController == nil) {
        [tableView reloadData];        
    }
    
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {	
    if ([delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [delegate performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

#pragma mark - UITextFieldDelegate

-(void)textFieldWillBecomeFirstResponder:(UITextField *)textField cell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:cell:indexPath:textFieldWillBecomeFirstResponder:)]) {
        [delegate tableViewControlled:self.tableView cell:cell indexPath:indexPath textFieldWillBecomeFirstResponder:textField];
    }
}

-(void)textFieldWillResignFirstResponder:(UITextField *)textField cell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(tableViewControlled:cell:indexPath:textFieldWillResignFirstResponder:)]) {
        [delegate tableViewControlled:self.tableView cell:cell indexPath:indexPath textFieldWillResignFirstResponder:textField];
    }
}

-(BOOL)textField:(UITextField *)textField
            cell:(GCTableCell *)cell
       indexPath:(NSIndexPath *)indexPath
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([delegate respondsToSelector:@selector(tableViewControlled:cell:indexPath:textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate tableViewControlled:self.tableView cell:cell indexPath:indexPath textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

@end
