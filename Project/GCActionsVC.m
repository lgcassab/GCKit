//
//  GCActionsVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 31/10/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionsVC.h"
#import "GCActionFadeVC.h"
#import "GCActionMoveVC.h"
#import "GCActionRotateVC.h"
#import "GCActionScaleVC.h"
#import "GCActionSequenceVC.h"

@interface GCActionsVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation GCActionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCActions"];
	
	_datasource = [NSMutableArray new];
	[_datasource addObject:@[@"GCActionCallFunc", @"GCActionSequenceVC"]];
	[_datasource addObject:@[@"GCActionDelay"   , @"GCActionSequenceVC"]];
	[_datasource addObject:@[@"GCActionFadeIn"  , @"GCActionFadeVC"]];
	[_datasource addObject:@[@"GCActionFadeOut" , @"GCActionFadeVC"]];
	[_datasource addObject:@[@"GCActionMoveBy"  , @"GCActionMoveVC"]];
	[_datasource addObject:@[@"GCActionMoveTo"  , @"GCActionMoveVC"]];
	[_datasource addObject:@[@"GCActionRotateBy", @"GCActionRotateVC"]];
	[_datasource addObject:@[@"GCActionRotateTo", @"GCActionRotateVC"]];
	[_datasource addObject:@[@"GCActionScaleBy" , @"GCActionScaleVC"]];
	[_datasource addObject:@[@"GCActionScaleTo" , @"GCActionScaleVC"]];
	[_datasource addObject:@[@"GCActionSequence", @"GCActionSequenceVC"]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"MyCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	[cell.textLabel setText:_datasource[indexPath.row][0]];
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	id class = NSClassFromString(_datasource[indexPath.row][1]);
	[self.navigationController pushViewController:[class new] animated:YES];
}

@end
