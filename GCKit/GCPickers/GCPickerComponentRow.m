//
//  GCPickerComponentRow.m
//  GCKit
//
//  Created by Gustavo Cassab on 22/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCPickerComponentRow.h"


@implementation GCPickerComponentRow
@synthesize title, tag;
@synthesize userObject;
@synthesize userObject2;
@synthesize userObject3;
@synthesize userObject4;
@synthesize userObject5;

+(id)componentWithTitle:(NSString *)_title {
	return [GCPickerComponentRow componentWithTitle:_title tag:-1];
}

+(id)componentWithTitle:(NSString *)_title userObject:(id)userObject {
	return [GCPickerComponentRow componentWithTitle:_title tag:-1 userObject:userObject];
}

+(id)componentWithTitle:(NSString *)_title tag:(NSInteger)_tag {
	GCPickerComponentRow *tmpRow = [[GCPickerComponentRow alloc]initWithTitle:_title tag:_tag];
	return tmpRow;
}

+(id)componentWithTitle:(NSString *)_title tag:(NSInteger)_tag userObject:(id)userObject {
	GCPickerComponentRow *tmpRow = [[GCPickerComponentRow alloc]initWithTitle:_title tag:_tag];
    [tmpRow setUserObject:userObject];
	return tmpRow;
}

-(id)init {
	
	if( (self=[super init] )) {
		self.title = nil;
		self.userObject = nil;
		self.userObject2 = nil;
		self.userObject3 = nil;
		self.userObject4 = nil;
		self.userObject5 = nil;        
	}
	
	return self;
}

-(id)initWithTitle:(NSString *)_title tag:(NSInteger)_tag {
	
	if( (self=[super init] )) {
		self.title = _title;
		self.tag = _tag;
	}
	
	return self;
}

@end
