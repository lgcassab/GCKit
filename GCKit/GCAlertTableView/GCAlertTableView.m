//
//  GCAlertTableView.m
//  GCKit
//
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.

#import "GCAlertTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "GCAlertTableViewBGView.h"
#import "GCAlertTableViewCell.h"

static ATVCancelBlock       _cancelBlock;
static ATVSelectionBlock    _selectionBlock;

@implementation GCAlertTableView
@synthesize tableView=_tableView;
@synthesize arrayDatasource;

#pragma mark - instance methods

+ (UIAlertView*) alertViewWithTitle:(NSString *)title                    
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                        arrayOfRows:(NSArray  *)arrayOfRows
                           onCancel:(ATVCancelBlock)cancelled
                        onSelectRow:(ATVSelectionBlock)selectedRow {
    
    _cancelBlock    = [cancelled copy];
    _selectionBlock = [selectedRow copy];
    
    GCAlertTableView *alert = [[self alloc] initWithTitle:title 
                                                      message:nil 
                                                     delegate:self 
                                            cancelButtonTitle:cancelButtonTitle 
                                            otherButtonTitles:nil];
    alert.arrayDatasource = arrayOfRows;
    
    [alert show];
    
	return alert;
}

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
           delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    if (self = [super initWithTitle:title message:@"\n\n\n\n\n\n\n" delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil]) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(11.0f, 50.0f, 261.0f, 147.0f) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
		_tableView.layer.cornerRadius = 5.0f;
		_tableView.separatorColor = [UIColor colorWithWhite:175.0f/255.0f alpha:0.0f];
		_tableView.backgroundColor = [UIColor whiteColor];
        #if __has_feature(objc_arc)
        _tableView.backgroundView = [[GCAlertTableViewBGView alloc] initWithFrame:_tableView.bounds];
        #else
        _tableView.backgroundView = [[[GCAlertTableViewBGView alloc] initWithFrame:_tableView.bounds] autorelease];
        #endif
        
        [self addSubview:_tableView];
        
        UIImage *image = [[UIImage imageNamed:@"GCAlertTableViewOverlayImage.png"]
						  resizableImageWithCapInsets:UIEdgeInsetsMake(7.0f, 5.0f, 6.0f, 5.0f)];
        
        #if __has_feature(objc_arc)
        _overlayImageView = [[UIImageView alloc] initWithImage:image];
        #else
        _overlayImageView = [[[UIImageView alloc] initWithImage:image]autorelease];
        #endif
        _overlayImageView.frame = _tableView.bounds;
        [_tableView addSubview:_overlayImageView];
    }
    return self;
}

#pragma mark - Overrides

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
	if(buttonIndex == [alertView cancelButtonIndex]) {
		_cancelBlock();
	} else {
        _selectionBlock(buttonIndex -1);
    }
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _overlayImageView.frame = _tableView.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    GCAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        #if __has_feature(objc_arc)
        cell = [[GCAlertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        #else
        cell = [[[GCAlertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        #endif
    }
    
    cell.textLabel.text = [arrayDatasource objectAtIndex:indexPath.row];
    [cell.textLabel setNumberOfLines:2];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithClickedButtonIndex:(indexPath.row +1) animated:YES];
}

#pragma mark - Memory Managment

-(void)dealloc {
    #if !__has_feature(objc_arc)
    [_cancelBlock release];
    [_selectionBlock release];
    [_tableView release];
    [arrayDatasource release];
    [super dealloc];
    #endif
}

@end
