//
//  GCAdditionsVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 31/10/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCAdditionsVC.h"

@interface GCAdditionsVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation GCAdditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"GCAdditions"];
	
	_datasource = [NSMutableArray new];
	[_datasource addObject:@""];
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
	
}

@end
