//
//  GCPickerDate.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerComponent.h"

@interface GCPickerDate: UIViewController {
	
	IBOutlet UIBarButtonItem *buttonCancel;
	IBOutlet UIBarButtonItem *buttonOk;	
	IBOutlet UIDatePicker *pickerView;
	
	UIWindow* window;
	
	UIView *backgroundView;
}
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property(nonatomic, retain)IBOutlet UIBarButtonItem *buttonCancel;
@property(nonatomic, retain)IBOutlet UIBarButtonItem *buttonOk;
@property(nonatomic, retain)IBOutlet UIDatePicker *pickerView;
@property(nonatomic, assign)id delegate;

-(id)initWithDelegate:(id)_delegate;

-(void)showPicker;
-(void)hidePicker;

-(IBAction)buttonCancelClicked:(id)sender;
-(IBAction)buttonOkClicked:(id)sender;

-(NSDate *)date;
-(void)setDatePickerMode:(UIDatePickerMode)mode;

@end

@protocol GCPickerDateDelegate <NSObject>
-(void)gcPickerDate:(GCPickerDate *)gcPicker buttonCancelPressed:(UIBarButtonItem *)buttonCancel;
-(void)gcPickerDate:(GCPickerDate *)gcPicker buttonOkPressed:(UIBarButtonItem *)buttonOk;
@optional
-(void)gcPickerDate:(GCPickerDate *)gcPicker dateDidChange:(NSDate *)date;
@end
