//
//  GCTableController.h
//  GCKit
//
//  Created by Gustavo Cassab on 10/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCTableSection.h"
#import "GCTableSectionExpandable.h"
#import "GCTableCell.h"

typedef enum {
    gcTableControllerSearchFieldTextLabel,
    gcTableControllerSearchFieldDetailTextLabel,    
} GCTableControllerSearchField;

@interface GCTableController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate> {
    id delegate;
    UITableView *tableView;
    
    @private
    NSMutableArray *arraySections;
    NSMutableDictionary *dictionaryKeyValues;
	
	UISearchDisplayController *searchDisplayController;
    BOOL searchActive;
    NSString *searchText;
    NSMutableArray *arrayFilter;
    
    GCTableControllerSearchField searchField;
    
    BOOL showIndexABC;
}
@property(nonatomic, retain)id delegate;
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *arraySections;
@property(nonatomic, retain)NSMutableDictionary *dictionaryKeyValues;

@property(nonatomic, retain)UISearchDisplayController *searchDisplayController;
@property(nonatomic, readwrite)BOOL searchActive;
@property(nonatomic, retain)NSString *searchText;
@property(nonatomic, retain)NSMutableArray *arrayFilter;

@property(nonatomic, readwrite)GCTableControllerSearchField searchField;
@property(nonatomic, readwrite)BOOL showIndexABC;

-(id)initWithTableView:(UITableView *)_tableView delegate:(id)_delegate;
-(id)initWithTableView:(UITableView *)_tableView delegate:(id)_delegate searchField:(GCTableControllerSearchField)gcTableControllerSearchField;
-(void)reloadData;

-(void)addSection:(GCTableSection *)_section;

-(void)insertSection:(GCTableSection *)_section;
-(void)insertSection:(GCTableSection *)_section withRowAnimation:(UITableViewRowAnimation)_rowAnimation;
-(void)insertSection:(GCTableSection *)_section animated:(BOOL)_animated;
-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index;
-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index animated:(BOOL)_animated;
-(void)insertSection:(GCTableSection *)_section atIndex:(NSUInteger)_index withRowAnimation:(UITableViewRowAnimation)_rowAnimation;

-(void)deleteAllSections;
-(void)deleteAllSectionsAnimated:(BOOL)_animated;
-(void)deleteSection:(GCTableSection *)_section;
-(void)deleteSection:(GCTableSection *)_section animated:(BOOL)_animated;
-(void)deleteSectionAtIndex:(NSUInteger)_index;
-(void)deleteSectionAtIndex:(NSUInteger)_index animated:(BOOL)_animated;
-(void)deleteSectionAtIndex:(NSUInteger)_index withRowAnimation:(UITableViewRowAnimation)_rowAnimation;
-(void)deleteSection:(GCTableSection *)_section withRowAnimation:(UITableViewRowAnimation)_rowAnimation;

-(void)expandableSection:(GCTableSectionExpandable *)section hasBeenExpanded:(BOOL)expanded;
-(void)scrollToCell:(GCTableCell *)cell atScrollPosition:(UITableViewScrollPosition )scrollPosition;

-(void)deleteCell:(GCTableCell *)_cell;

-(NSUInteger)indexForSection:(GCTableSection *)section;
-(NSIndexPath *)indexPathForCell:(GCTableCell *)cell;

-(void)setValue:(id)value toInternalDictionaryKey:(NSString *)key;
-(id)valueForDictionaryKey:(NSString *)key;

-(void)valueChangedForCell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath object:(id)object;

-(void)setSearchBar:(UISearchBar *)searchBar;
-(void)setSearchBar:(UISearchBar *)searchBar searchField:(GCTableControllerSearchField)gcTableControllerSearchField;

-(NSUInteger)count;
-(GCTableCell *)selectedCell;

-(UIScrollView *)scrollView;

-(void)textFieldWillBecomeFirstResponder:(UITextField *)textField cell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath;
-(void)textFieldWillResignFirstResponder:(UITextField *)textField cell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath;
-(void)textField:(UITextField *)textField cell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath;
-(BOOL)textField:(UITextField *)textField
            cell:(GCTableCell *)cell
       indexPath:(NSIndexPath *)indexPath
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end


@protocol GCTableControllerDelegate <NSObject>
@optional

-(void)tableViewControlled:(UITableView *)tableView willConfigureSection:(GCTableSection *)_section atIndex:(NSUInteger)_index;

-(void)tableViewControlled:(UITableView *)tableView willConfigureCell:(GCTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableViewControlled:(UITableView *)tableView valueChangedForCell:(GCTableCell *)cell indexPath:(NSIndexPath *)indexPath object:(id)object;

-(void)tableViewControlled:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath cell:(GCTableCell *)cell;
-(NSIndexPath *)tableViewControlled:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)tableViewControlled:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableViewControlled:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cell:(GCTableCell *)cell;
-(void)tableViewControlled:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath cell:(GCTableCell *)cell;

-(void)tableViewControlled:(UITableView *)tableView willBeginSearch:(UISearchDisplayController *)controller;
-(void)tableViewControlled:(UITableView *)tableView didBeginSearch:(UISearchDisplayController *)controller;
-(void)tableViewControlled:(UITableView *)tableView willEndSearch:(UISearchDisplayController *)controller;
-(void)tableViewControlled:(UITableView *)tableView didEndSearch:(UISearchDisplayController *)controller;

-(void)tableViewControlled:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath cell:(GCTableCell *)cell;

- (NSArray *)sectionIndexTitlesForTableViewControlled:(UITableView *)tableView; 
- (NSInteger)tableViewControlled:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

-(void)tableViewControlled:(UITableView *)tableView expandableSection:(GCTableSectionExpandable *)section hasBeenExpanded:(BOOL)expanded;

-(void)tableViewControlled:(UITableView *)tableView
                      cell:(GCTableCell *)cell
                 indexPath:(NSIndexPath *)indexPath
textFieldWillBecomeFirstResponder:(UITextField *)_textField;

-(void)tableViewControlled:(UITableView *)tableView
                      cell:(GCTableCell *)cell
                 indexPath:(NSIndexPath *)indexPath
textFieldWillResignFirstResponder:(UITextField *)_textField;

-(BOOL)tableViewControlled:(UITableView *)tableView
                      cell:(GCTableCell *)cell
                 indexPath:(NSIndexPath *)indexPath
                 textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
         replacementString:(NSString *)string;

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)tableView:(UITableView *)_tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end