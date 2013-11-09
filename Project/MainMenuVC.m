//
//  MainMenuVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 16/10/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import "MainMenuVC.h"

@interface MainMenuVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation MainMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"GCKit"];

	_datasource = [NSMutableArray new];
	[_datasource addObject:@"GCActions"];
	[_datasource addObject:@"GCAdditions"];
//	[_datasource addObject:@"GCAnimation"];
//	[_datasource addObject:@"GCBadgeView"];
//	[_datasource addObject:@"GCEffects"];
//	[_datasource addObject:@"GCEncrypt"];
//	[_datasource addObject:@"GCFileManager"];
//	[_datasource addObject:@"GCKeychain"];
//	[_datasource addObject:@"GCMailComposer"];
//	[_datasource addObject:@"GCParseXML"];
//	[_datasource addObject:@"GCPopController"];
//	[_datasource addObject:@"GCSplashVideo"];
//	[_datasource addObject:@"GCTextFieldDelegate"];
//	[_datasource addObject:@"GCYoutube"];
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
	
	[cell.textLabel setText:[_datasource objectAtIndex:indexPath.row]];
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	id class = NSClassFromString([NSString stringWithFormat:@"%@VC", _datasource[indexPath.row]]);
	[self.navigationController pushViewController:[class new] animated:YES];
}

@end
