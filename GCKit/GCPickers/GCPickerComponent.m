//
//  GCPickerComponent.m
//  GCKit
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerComponent.h"

@implementation GCPickerComponent
@synthesize arrayRows;
@synthesize width, rowHeight;

-(id) init {
	
	if( (self=[super init] )) {
		
		{
			NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
			self.arrayRows = tmpArray;
		}
		
		self.rowHeight = -1;
		self.width = -1;
		
	}
	
	return self;
}

-(void)addRow:(GCPickerComponentRow *)row {
	[arrayRows addObject:row];
}

-(NSInteger)rows {
	return [arrayRows count];
}

-(NSInteger)count {
	return [arrayRows count];
}

-(NSString *)titleAtRow:(NSInteger)row {
	return [(GCPickerComponentRow *)[arrayRows objectAtIndex:row] title];
}

-(NSInteger)tagAtRow:(NSInteger)row {
	return [(GCPickerComponentRow *)[arrayRows objectAtIndex:row] tag];
}

@end
