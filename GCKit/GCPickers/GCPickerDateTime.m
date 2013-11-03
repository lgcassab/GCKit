//
//  GCPickerDateTime.m
//  GCKit 
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerDateTime.h"

@interface GCPickerDateTime (Private)
#define _animationDelay 0.35f
@end

@implementation GCPickerDateTime
@synthesize buttonCancel, buttonOk, pickerView;
@synthesize delegate;

-(id)initWithDelegate:(id)_delegate {
	
	self = [super initWithNibName:@"GCPickerDateTime" bundle:nil];
	
	if (self) {
		
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
		
		[pickerView addTarget:self action:@selector(pickerViewValueChanged:) forControlEvents:UIControlEventValueChanged];
		
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
#pragma mark GCPickerDateTimeDelegate

-(NSDate *)date {
	return [pickerView date];
}

-(void)setDatePickerMode:(UIDatePickerMode)mode {
	[self.pickerView setDatePickerMode:mode];
}

-(void)pickerViewValueChanged:(id)sender {
	if ([delegate respondsToSelector:@selector(gcPickerDateTime:dateTimeDidChange:)]) {
		[delegate gcPickerDateTime:self dateTimeDidChange:[pickerView date]];
	}
}

#pragma mark -
#pragma mark Actions 

-(IBAction)buttonCancelClicked:(id)sender {
	
	NSString *warningMessage = [NSString stringWithFormat:@"Delegate '%@' does not fully implement the 'GCPickerDateTimeDelegate' protocol", [delegate class] ];
	NSAssert( [delegate respondsToSelector:@selector(gcPickerDateTime:buttonCancelPressed:)], warningMessage);

	[delegate gcPickerDateTime:self buttonCancelPressed:(UIBarButtonItem *)sender];
}

-(IBAction)buttonOkClicked:(id)sender {
	
	NSString *warningMessage = [NSString stringWithFormat:@"Delegate '%@' does not fully implement the 'GCPickerDateTimeDelegate' protocol", [delegate class] ];
	NSAssert( [delegate respondsToSelector:@selector(gcPickerDateTime:buttonOkPressed:)], warningMessage);
	
	[delegate gcPickerDateTime:self buttonOkPressed:(UIBarButtonItem *)sender];
}

@end
