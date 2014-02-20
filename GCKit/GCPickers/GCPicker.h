//
//  GCPicker.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerComponent.h"

@interface GCPicker : UIViewController <UIPickerViewDelegate> {
	
	IBOutlet UIBarButtonItem *buttonCancel;
	IBOutlet UIBarButtonItem *buttonOk;	
	IBOutlet UIPickerView *pickerView;
	
	UIWindow* window;
	
	UIView *backgroundView;
	
	NSMutableArray *arrayComponents;
    
    NSUInteger selectedRow;
}
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property(nonatomic, strong)IBOutlet UIBarButtonItem *buttonCancel;
@property(nonatomic, strong)IBOutlet UIBarButtonItem *buttonOk;
@property(nonatomic, strong)IBOutlet UIPickerView *pickerView;
@property(nonatomic, assign)id delegate;
@property(nonatomic, strong)NSMutableArray *arrayComponents;
@property (nonatomic, readwrite) NSUInteger selectedRow;

-(id)initWithDelegate:(id)_delegate;

-(void)showPicker;
-(void)hidePicker;

-(IBAction)buttonCancelClicked:(id)sender;
-(IBAction)buttonOkClicked:(id)sender;

-(void)addComponent:(GCPickerComponent *)component;

-(NSString *)selectedTitleInComponent:(NSInteger)component;
-(NSInteger)selectedTagInComponent:(NSInteger)component;

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
-(void)selectRowWithTitle:(NSString *)title inComponent:(NSInteger)component animated:(BOOL)animated;
-(void)selectRowWithTag:(NSInteger)tag inComponent:(NSInteger)component animated:(BOOL)animated;

@end

@protocol GCPickerDelegate <NSObject>
-(void)gcPicker:(GCPicker *)gcPicker buttonCancelPressed:(UIBarButtonItem *)buttonCancel;
-(void)gcPicker:(GCPicker *)gcPicker buttonOkPressed:(UIBarButtonItem *)buttonOk;
@optional
- (void)gcPicker:(GCPicker *)gcPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)gcPicker:(GCPicker *)gcPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component componentRow:(GCPickerComponentRow *)componentRow;
- (void)gcPicker:(GCPicker *)gcPicker didSelectTitle:(NSString *)title;
@end
