//
//  GCAnimationVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimationVC.h"
#import "GCAnimationTransitionVC.h"

@interface GCAnimationVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation GCAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCAnimation"];
	
	_datasource = [NSMutableArray new];
    [_datasource addObject:@[@"GCAnimationTransition", @"GCAnimationTransitionVC"]];
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
	
	GCAnimationTransitionVC *viewController = [[GCAnimationTransitionVC alloc] initWithNibName:@"GCAnimationTransitionVC" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
}

@end
