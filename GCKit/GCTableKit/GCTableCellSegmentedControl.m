//
//  GCTableCellSegmentedControl.m
//  GCKit
//
//  Created by Gustavo Cassab on 14/05/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellSegmentedControl.h"
#import "GCTableController.h"

@implementation GCTableCellSegmentedControl
@synthesize segmentedControl;

+(id)cellWithItems:(NSArray *)items dictionaryKey:(NSString *)dictKey {
    return [[self alloc]initWithItems:items dictionaryKey:dictKey defaultItem:0];    
}

+(id)cellWithItems:(NSArray *)items dictionaryKey:(NSString *)dictKey defaultItem:(NSUInteger )defaultItem {
    return [[self alloc]initWithItems:items dictionaryKey:dictKey defaultItem:defaultItem];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if( (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) ) 	{
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		lockCellSelection = YES;
	}
	return self;
}

-(id)initWithItems:(NSArray *)items dictionaryKey:(NSString *)dictKey defaultItem:(NSUInteger )defaultItem {
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if(self) {
        
        self.dictionaryKey = dictKey;        
        
        if (dictionaryKey != nil) {
            [self.tableController.dictionaryKeyValues setValue:[NSNumber numberWithInt:defaultItem] forKey:dictionaryKey];
        }
        
        self.segmentedControl = [[UISegmentedControl alloc]initWithItems:items];
        [segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];        
        [segmentedControl setSelectedSegmentIndex:defaultItem];
        
		[self.contentView addSubview:segmentedControl];
    }
    
    return self;
}

- (void)layoutSubviews {
    
	[super layoutSubviews];
	
    self.contentView.frame = self.backgroundView.frame;
    self.segmentedControl.frame = self.contentView.bounds;
    
    [self.textLabel setHidden:YES];
    [self.detailTextLabel setHidden:YES];
    
    [self.contentView bringSubviewToFront:self.segmentedControl];
}

#pragma mark - Actions

-(void)segmentedControlChanged:(id)sender {
    
    if (dictionaryKey != nil) {
        [self.tableController.dictionaryKeyValues setValue:[NSNumber numberWithInt:[segmentedControl selectedSegmentIndex]] 
                                                    forKey:dictionaryKey];
    }
    
    NSIndexPath *ip = [self.tableController indexPathForCell:self];
    if ([self.tableController respondsToSelector:@selector(valueChangedForCell:indexPath:object:)]) {
        [self.tableController valueChangedForCell:self indexPath:ip object:segmentedControl];    
    }
}

@end
