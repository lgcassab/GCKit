//
//  GCDatabaseRequest.h
//  GCDatabase

#import <Foundation/Foundation.h>

typedef enum {
	GCDatabaseUpdateRequest,
	GCDatabaseSelectRequest
} GCDatabaseRequestKind;

@class GCDatabase, GCDatabaseResult;

@protocol GCDatabaseRequestDelegate;

@interface GCDatabaseRequest : NSOperation {
@private
	NSArray* parameters;
	NSInteger tag;
	NSString* query;
	GCDatabase* database;
	GCDatabaseRequestKind requestKind;
	id<GCDatabaseRequestDelegate> __weak delegate;
}

- (id)initWithQuery:(NSString*)aQuery;
- (id)initWithQuery:(NSString*)aQuery parameters:(NSArray*)someParameters;

@property(nonatomic,assign) NSInteger tag;
@property(nonatomic,strong) GCDatabase* database;
@property(nonatomic,assign) GCDatabaseRequestKind requestKind;
@property(nonatomic,weak) id<GCDatabaseRequestDelegate> delegate;
@end

@protocol GCDatabaseRequestDelegate<NSObject>
- (void)requestDidSucceed:(GCDatabaseRequest*)request withResult:(GCDatabaseResult*)result; // result will be nil for GCDatabaseUpdateRequest
- (void)requestDidFail:(GCDatabaseRequest*)request withError:(NSError*)error;
@end
