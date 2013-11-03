//
//  GCPickerComponent.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//


#import "GCPickerComponentRow.h"

@interface GCPickerComponent : NSObject {
	NSMutableArray *arrayRows;
	CGFloat width;
	CGFloat rowHeight;
}
@property(nonatomic, retain)NSMutableArray *arrayRows;
@property(nonatomic, readwrite)CGFloat width;
@property(nonatomic, readwrite)CGFloat rowHeight;

-(void)addRow:(GCPickerComponentRow *)row;
-(NSInteger)rows;
-(NSInteger)count;
-(NSString *)titleAtRow:(NSInteger)row;
-(NSInteger)tagAtRow:(NSInteger)row;

@end
