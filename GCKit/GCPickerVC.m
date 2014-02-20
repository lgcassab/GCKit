//
//  GCPickerVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 20/02/14.
//  Copyright (c) 2014 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerVC.h"
#import "GCKit.h"

@interface GCPickerVC () <GCPickerDateDelegate , GCPickerDateTimeDelegate>
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) GCPickerDate *pickerDate;
@property (nonatomic, strong) GCPickerDateTime *pickerDateTime;
@end

@implementation GCPickerVC

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setClearsSelectionOnViewWillAppear:YES];
	[self setTitle:@"GCPickerVC"];
	
	_datasource = [NSMutableArray new];
	[_datasource addObject:@"GCPickerDate"];
	[_datasource addObject:@"GCPickerDateTime"];
	
	_pickerDate = [[GCPickerDate alloc] initWithDelegate:self];
	_pickerDateTime = [[GCPickerDateTime alloc] initWithDelegate:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"MyCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	
	[cell.textLabel setText:[_datasource objectAtIndex:indexPath.row]];
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0: { [self showPickerDate]; break; }
		case 1: { [self showPickerDateTime]; break; }
	}
}

#pragma mark - Private Methods

- (void)showPickerDate {
	GCLog(@"showPickerDate");
	[_pickerDate showPicker];
}

- (void)showPickerDateTime {
	GCLog(@"showPickerDateTime");
	[_pickerDateTime showPicker];
}

#pragma mark - GCPickerDateDelegate

- (void)gcPickerDate:(GCPickerDate *)gcPicker buttonCancelPressed:(UIBarButtonItem *)buttonCancel {
	GCLog(@"gcPickerDate:buttonCancelPressed:");
	[gcPicker hidePicker];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)gcPickerDate:(GCPickerDate *)gcPicker buttonOkPressed:(UIBarButtonItem *)buttonOk {
	GCLog(@"gcPickerDate:buttonOkPressed: %@", gcPicker.date);
	[gcPicker hidePicker];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)gcPickerDate:(GCPickerDate *)gcPicker dateDidChange:(NSDate *)date {
	GCLog(@"gcPickerDate:dateDidChange: %@", date);

	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
	[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", date]];
}

#pragma mark - GCPickerDateTimeDelegate

- (void)gcPickerDateTime:(GCPickerDateTime *)gcPicker buttonCancelPressed:(UIBarButtonItem *)buttonCancel {
	GCLog(@"gcPickerDateTime:buttonCancelPressed:");
	[gcPicker hidePicker];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)gcPickerDateTime:(GCPickerDateTime *)gcPicker buttonOkPressed:(UIBarButtonItem *)buttonOk {
	GCLog(@"gcPickerDateTime:buttonOkPressed: %@", gcPicker.date);
	
	[gcPicker hidePicker];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)gcPickerDateTime:(GCPickerDateTime *)gcPicker dateTimeDidChange:(NSDate *)date {
	GCLog(@"gcPickerDateTime:dateTimeDidChange: %@", date);
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
	[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", date]];
}

@end
