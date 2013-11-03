//
//  GCPicker.m
//  GCKit 
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPicker.h"

@interface GCPicker (Private)
#define _animationDelay 0.35f
@end

@implementation GCPicker
@synthesize buttonCancel, buttonOk, pickerView;
@synthesize delegate;
@synthesize arrayComponents;
@synthesize selectedRow;

-(id)initWithDelegate:(id)_delegate {
	
	self = [super initWithNibName:@"GCPicker" bundle:nil];
	
	if (self) {
		
		{
			NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
			self.arrayComponents = tmpArray;
		}
		
		self.delegate = _delegate;
		
		window = [UIApplication sharedApplication].keyWindow;
		if (!window) {
			window = [[UIApplication sharedApplication].windows objectAtIndex:0];
		}
		
		[self.view setFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
		
		[self.view setCenter:CGPointMake(self.view.center.x, 
										 (window.frame.size.height + (self.view.frame.size.height / 2) ) )];
		
		[window addSubview:self.view];

		{
			backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
			[backgroundView setBackgroundColor:[UIColor blackColor]];
			[backgroundView setAlpha:0];
			[self.view addSubview:backgroundView];
			[self.view sendSubviewToBack:backgroundView];
		}
        
        self.selectedRow = 0;
		
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Animations 

-(void)showPicker {
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:_animationDelay];	
	[UIView setAnimationDelegate:self];	
	[UIView setAnimationDidStopSelector:@selector(showBackgroundView)];
	[self.view setCenter:CGPointMake(self.view.center.x, (window.frame.size.height - (self.view.frame.size.height / 2) ) )];
	[UIView commitAnimations];
}

-(void)showBackgroundView {
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:_animationDelay *2];	
	[backgroundView setAlpha:0.5];
	[UIView commitAnimations];
}

-(void)hidePicker {

	[backgroundView setAlpha:0];	
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:_animationDelay];	
	[self.view setCenter:CGPointMake(self.view.center.x, (window.frame.size.height + (self.view.frame.size.height / 2) ) )];
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Actions 

-(IBAction)buttonCancelClicked:(id)sender {
	
	NSString *warningMessage = [NSString stringWithFormat:@"Delegate '%@' does not fully implement the 'GCPickerDelegate' protocol", [delegate class] ];
	NSAssert( [delegate respondsToSelector:@selector(gcPicker:buttonCancelPressed:)], warningMessage);

	[delegate gcPicker:self buttonCancelPressed:(UIBarButtonItem *)sender];
}

-(IBAction)buttonOkClicked:(id)sender {
	
	NSString *warningMessage = [NSString stringWithFormat:@"Delegate '%@' does not fully implement the 'GCPickerDelegate' protocol", [delegate class] ];
	NSAssert( [delegate respondsToSelector:@selector(gcPicker:buttonOkPressed:)], warningMessage);
	
	[delegate gcPicker:self buttonOkPressed:(UIBarButtonItem *)sender];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return [arrayComponents count];
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [(GCPickerComponent *)[arrayComponents objectAtIndex:component]rows];
}

#pragma mark -
#pragma mark GCPickerComponent

-(void)addComponent:(GCPickerComponent *)component {
	[arrayComponents addObject:component];
}

-(NSString *)selectedTitleInComponent:(NSInteger)component {
	NSString *ret;
	
	GCPickerComponent *comp = [arrayComponents objectAtIndex:component];
	ret = [comp titleAtRow:[pickerView selectedRowInComponent:component]];
	
	return ret;
}

-(NSInteger)selectedTagInComponent:(NSInteger)component {
	GCPickerComponent *comp = [arrayComponents objectAtIndex:component];
	int ret = [comp tagAtRow:[pickerView selectedRowInComponent:component]];
	return ret;
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
	[pickerView selectRow:row inComponent:component animated:animated];
}

-(void)selectRowWithTitle:(NSString *)title inComponent:(NSInteger)component animated:(BOOL)animated {
	GCPickerComponent *comp = [arrayComponents objectAtIndex:component];
	for (GCPickerComponentRow *row in [comp arrayRows]) {
		if ([[row title] compare:title] == NSOrderedSame) {
			[pickerView selectRow:[[comp arrayRows]indexOfObject:row] inComponent:component animated:animated];
		}
	}
}

-(void)selectRowWithTag:(NSInteger)tag inComponent:(NSInteger)component animated:(BOOL)animated {
	GCPickerComponent *comp = [arrayComponents objectAtIndex:component];
	for (GCPickerComponentRow *row in [comp arrayRows]) {
		if ([row tag] == tag) {
			[pickerView selectRow:[[comp arrayRows]indexOfObject:row] inComponent:component animated:animated];
		}
	}
}

#pragma mark -
#pragma mark UIPickerViewDelegate

// returns width of column and height of row for each component. 
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	GCPickerComponent *comp = [arrayComponents objectAtIndex:component];
	return [comp titleAtRow:row];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedRow = row;
	
	if ([delegate respondsToSelector:@selector(gcPicker:didSelectRow:inComponent:)]) {
		[delegate gcPicker:self didSelectRow:row inComponent:component];
	}
	
	if ([delegate respondsToSelector:@selector(gcPicker:didSelectTitle:)]) {
		NSString *title = [(GCPickerComponent *)[arrayComponents objectAtIndex:component]titleAtRow:row];
		[delegate gcPicker:self didSelectTitle:title];
	}
	
    if ([delegate respondsToSelector:@selector(gcPicker:didSelectRow:inComponent:componentRow:)]) {
        
        GCPickerComponent *tmpComponent = (GCPickerComponent *)[arrayComponents objectAtIndex:component];
        GCPickerComponentRow *componentRow = [tmpComponent.arrayRows objectAtIndex:row];
        
		[delegate gcPicker:self didSelectRow:row inComponent:component componentRow:componentRow];
	}
}

@end
