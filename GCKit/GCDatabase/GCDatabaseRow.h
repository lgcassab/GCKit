//
//  GCDatabaseRow.h
//  GCDatabase

#import <Foundation/Foundation.h>

@class GCDatabaseResult;

@interface GCDatabaseRow : NSObject {
@private
	NSMutableArray* columnData;
	GCDatabaseResult* result;
}

- (id)initWithDatabaseResult:(GCDatabaseResult*)aResult;

- (int)intForColumn:(NSString*)columnName;
- (int)intForColumnIndex:(int)columnIdx;

- (long)longForColumn:(NSString*)columnName;
- (long)longForColumnIndex:(int)columnIdx;

- (BOOL)boolForColumn:(NSString*)columnName;
- (BOOL)boolForColumnIndex:(int)columnIdx;

- (double)doubleForColumn:(NSString*)columnName;
- (double)doubleForColumnIndex:(int)columnIdx;

- (NSString*)stringForColumn:(NSString*)columnName;
- (NSString*)stringForColumnIndex:(int)columnIdx;

- (NSData*)dataForColumn:(NSString*)columnName;
- (NSData*)dataForColumnIndex:(int)columnIndex;

- (NSDate*)dateForColumn:(NSString*)columnName;
- (NSDate*)dateForColumnIndex:(int)columnIdx;

@property(readonly) NSMutableArray* columnData;
@end
