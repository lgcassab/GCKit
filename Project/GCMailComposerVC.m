//
//  GCMailComposerVC.m
//  GCKit
//
//  Created by Gustavo Cassab on 20/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCMailComposerVC.h"
#import "GCKit.h"

@interface GCMailComposerVC ()
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation GCMailComposerVC

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setClearsSelectionOnViewWillAppear:YES];
	[self setTitle:@"GCMailComposerVC"];
	
	_datasource = [NSMutableArray new];
	[_datasource addObject:@"Simple mail"];
	[_datasource addObject:@"Mail as html"];
	[_datasource addObject:@"Text mail with attachments"];
	[_datasource addObject:@"Html mail with attachments"];
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
	
	[cell.textLabel setText:[_datasource objectAtIndex:indexPath.row]];
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0: { [self sendSimpleMail]; break; }
		case 1: { [self sendMailAsHtml]; break; }
		case 2: { [self sendTextMailWithAttachments]; break; }
		case 3: { [self sendHtmlMailWithAttachments]; break; }
	}
}

#pragma mark - Private Methods

- (void)sendSimpleMail {
	[GCMailComposer mailTo:@[@"mailto@address.com"]
				   subject:@"My subject"
		 completitionBlock:^(MFMailComposeResult result, NSError *error) {
			 switch (result) {
				 case MFMailComposeResultCancelled: { GCLog(@"MFMailComposeResultCancelled"); break; }
				 case MFMailComposeResultSaved:     { GCLog(@"MFMailComposeResultSaved"); break; }
				 case MFMailComposeResultSent:      { GCLog(@"MFMailComposeResultSent"); break; }
				 case MFMailComposeResultFailed:    { GCLog(@"MFMailComposeResultFailed"); break; }
			 }
		 }];
}

- (void)sendMailAsHtml {
	[GCMailComposer mailTo:@[@"mailto@address.com"]
				   subject:@"My subject"
				bodyAsHtml:@"<html><body>This is my body</body></html>"
		 completitionBlock:^(MFMailComposeResult result, NSError *error) {
			 switch (result) {
				 case MFMailComposeResultCancelled: { GCLog(@"MFMailComposeResultCancelled"); break; }
				 case MFMailComposeResultSaved:     { GCLog(@"MFMailComposeResultSaved"); break; }
				 case MFMailComposeResultSent:      { GCLog(@"MFMailComposeResultSent"); break; }
				 case MFMailComposeResultFailed:    { GCLog(@"MFMailComposeResultFailed"); break; }
			 }
		 }];
}

- (void)sendTextMailWithAttachments {
	[GCMailComposer mailTo:@[@"mailto@address.com"]
				   subject:@"My subject"
				bodyAsText:@"This is my body"
				attachment:@[[GCMailComposer imageName:@"MyFile.png" png:[UIImage imageNamed:@"Paisagem"]]]
		 completitionBlock:^(MFMailComposeResult result, NSError *error) {
			 switch (result) {
				 case MFMailComposeResultCancelled: { GCLog(@"MFMailComposeResultCancelled"); break; }
				 case MFMailComposeResultSaved:     { GCLog(@"MFMailComposeResultSaved"); break; }
				 case MFMailComposeResultSent:      { GCLog(@"MFMailComposeResultSent"); break; }
				 case MFMailComposeResultFailed:    { GCLog(@"MFMailComposeResultFailed"); break; }
			 }
		 }];
}

- (void)sendHtmlMailWithAttachments {
	[GCMailComposer mailTo:@[@"mailto@address.com"]
				   subject:@"My subject"
				bodyAsHtml:@"<html><body>This is my body</body></html>"
				attachment:@[[GCMailComposer imageName:@"MyFile.png" png:[UIImage imageNamed:@"Paisagem"]]]
		 completitionBlock:^(MFMailComposeResult result, NSError *error) {
			 switch (result) {
				 case MFMailComposeResultCancelled: { GCLog(@"MFMailComposeResultCancelled"); break; }
				 case MFMailComposeResultSaved:     { GCLog(@"MFMailComposeResultSaved"); break; }
				 case MFMailComposeResultSent:      { GCLog(@"MFMailComposeResultSent"); break; }
				 case MFMailComposeResultFailed:    { GCLog(@"MFMailComposeResultFailed"); break; }
			 }
		 }];
}

@end
