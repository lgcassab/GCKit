//
//  GCDatabaseResult.h
//  GCDatabase

#import <Foundation/Foundation.h>

@class GCDatabaseRow;

@interface GCDatabaseResult : NSObject<NSFastEnumeration> {
@private
	int errorCode;
	NSString* errorMessage;
	NSMutableArray* columnNames;
	NSMutableArray* columnTypes;
	NSMutableArray* rows;
}

- (void)addRow:(GCDatabaseRow*)row;
- (GCDatabaseRow*)rowAtIndex:(NSInteger)index;
- (NSUInteger)count;

@property(nonatomic,assign) int errorCode;
@property(nonatomic,copy) NSString* errorMessage;
@property(readonly) NSMutableArray* columnNames;
@property(readonly) NSMutableArray* columnTypes;
@property(readonly) NSMutableArray* rows;
@end
