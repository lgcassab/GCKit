//
//  GCAnimationTransitionVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimationTransitionVC.h"

@interface GCAnimationTransitionVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation GCAnimationTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"GCAnimationTransition"];
	
	_datasource = [NSMutableArray new];
    [_datasource addObject:@[@"Transition Fade"        , @""]];
    [_datasource addObject:@[@"Transition From Bottom" , @""]];
    [_datasource addObject:@[@"Transition From Left"   , @""]];
    [_datasource addObject:@[@"Transition From Right"  , @""]];
    [_datasource addObject:@[@"Transition From Top"    , @""]];
    [_datasource addObject:@[@"Transition Move In"     , @""]];
    [_datasource addObject:@[@"Transition Push"        , @""]];
    [_datasource addObject:@[@"Transition Reveal"      , @""]];
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
