//
//  GCDatabase.m
//  GCDatabase

#define VAToArray(firstarg) ({\
    NSMutableArray* valistArray = [NSMutableArray array];\
    id obj = nil;\
    va_list arguments;\
    va_start(arguments, sql);\
    while ((obj = va_arg(arguments, id))) {\
        [valistArray addObject:obj];\
    }\
    va_end(arguments);\
    valistArray;\
})

#import "GCDatabase.h"

#define GCEgoDatabaseDebugLog 1
#define GCEgoDatabaseLockLog 0

#if GCEgoDatabaseDebugLog
#define GCEgoDBDebugLog(s,...) NSLog(s, ##__VA_ARGS__)
#else
#define GCEgoDBDebugLog(s,...)
#endif

#if GCEgoDatabaseLockLog
#define GCEgoDBLockLog(s,...) NSLog(s, ##__VA_ARGS__)
#else
#define GCEgoDBLockLog(s,...)
#endif

@interface GCDatabase (Private)
- (BOOL)bindStatement:(sqlite3_stmt*)statement toParameters:(NSArray*)parameters;
- (void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt;
@end

@implementation GCDatabase
@synthesize sqliteHandle=handle;

+ (id)databaseWithPath:(NSString*)aPath {
	return [[[self class] alloc] initWithPath:aPath];
}

+ (id)databaseWithAliasKeyPath:(NSString*)aliasKeyPath {
    NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:aliasKeyPath];
	return [[[self class] alloc] initWithPath:path];
}

- (id)initWithPath:(NSString*)aPath {
	if((self = [super init])) {
		databasePath = aPath;
		executeLock = [[NSLock alloc] init];
	}
	
	return self;
}

+(BOOL)loadDatabase:(NSString *)database ofType:(NSString *)type aliasKeyPath:(NSString *)aliasKeyPath {
    BOOL success = NO;
    
    NSString *oPath = [[NSBundle mainBundle] pathForResource:database ofType:type];
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", database, type]];
	[[NSUserDefaults standardUserDefaults] setObject:dbPath forKey:aliasKeyPath];
    
	success = [fileManager fileExistsAtPath:dbPath];
	if (!success) {
		success = [fileManager copyItemAtPath:oPath toPath:dbPath error:&error];
	}
    
    return success;
}

- (GCDatabaseRequest*)requestWithQueryAndParameters:(NSString*)sql, ... {
	return [self requestWithQuery:sql parameters:VAToArray(sql)];
}

- (GCDatabaseRequest*)requestWithQuery:(NSString*)sql {
	return [self requestWithQuery:sql parameters:nil];
}

- (GCDatabaseRequest*)requestWithQuery:(NSString*)sql parameters:(NSArray*)parameters {
	GCDatabaseRequest* request = [[GCDatabaseRequest alloc] initWithQuery:sql parameters:parameters];

	request.database = self;
	request.requestKind = GCDatabaseSelectRequest;
	
	return request;
}

- (GCDatabaseRequest*)requestWithUpdateAndParameters:(NSString*)sql, ... {
	return [self requestWithUpdate:sql parameters:VAToArray(sql)];
}

- (GCDatabaseRequest*)requestWithUpdate:(NSString*)sql {
	return [self requestWithUpdate:sql parameters:nil];
}

- (GCDatabaseRequest*)requestWithUpdate:(NSString*)sql parameters:(NSArray*)parameters {
	GCDatabaseRequest* request = [[GCDatabaseRequest alloc] initWithQuery:sql parameters:parameters];

	request.database = self;
	request.requestKind = GCDatabaseUpdateRequest;
	
	return request;
}

- (BOOL)open {
	if(opened) return YES;
	
	int err = sqlite3_open([databasePath fileSystemRepresentation], &handle);

	if(err != SQLITE_OK) {
		GCEgoDBDebugLog(@"[GCDatabase] Error opening DB: %d", err);
		return NO;
	}
	
	opened = YES;
	return YES;
}

- (void)close {
	if(!handle) return;
	sqlite3_close(handle);
	opened = NO;
}

- (BOOL)executeUpdateWithParameters:(NSString*)sql,... {
	return [self executeUpdate:sql parameters:VAToArray(sql)];
}

- (BOOL)executeUpdate:(NSString*)sql {
	return [self executeUpdate:sql parameters:nil];
}

- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters {
	GCEgoDBLockLog(@"[Update] Waiting for Lock (%@): %@ %@", [sql md5], sql, [NSThread isMainThread] ? @"** Alert: Attempting to lock on main thread **" : @"");
	[executeLock lock];
	GCEgoDBLockLog(@"[Update] Got Lock (%@)", [sql md5]);
	
	if(![self open]) {
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return NO;
	}

	int returnCode = 0;
	sqlite3_stmt* statement = NULL;

	returnCode = sqlite3_prepare(handle, [sql UTF8String], -1, &statement, 0);
	
	if (SQLITE_BUSY == returnCode) {
		GCEgoDBLockLog(@"[GCDatabase] Query Failed, Database Busy:\n%@\n\n", sql);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return NO;
	} else if (SQLITE_OK != returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] Query Failed, Error: %d \"%@\"\n%@\n\n", [self lastErrorCode], [self lastErrorMessage], sql);
		sqlite3_finalize(statement);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return NO;
	}
	
	
	if (![self bindStatement:statement toParameters:parameters]) {
		GCEgoDBDebugLog(@"[GCDatabase] Invalid bind cound for number of arguments.");
		sqlite3_finalize(statement);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return NO;
	}
	
	returnCode = sqlite3_step(statement);
	
	if (SQLITE_BUSY == returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] Query Failed, Database Busy:\n%@\n\n", sql);
	} else if (SQLITE_DONE == returnCode || SQLITE_ROW == returnCode) {
		
	} else if (SQLITE_ERROR == returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] sqlite3_step Failed: (%d: %@) SQLITE_ERROR\n%@\n\n", returnCode, [self lastErrorMessage], sql);
	} else if (SQLITE_MISUSE == returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] sqlite3_step Failed: (%d: %@) SQLITE_MISUSE\n%@\n\n", returnCode, [self lastErrorMessage], sql);
	} else {
		GCEgoDBDebugLog(@"[GCDatabase] sqlite3_step Failed: (%d: %@) UNKNOWN_ERROR\n%@\n\n", returnCode, [self lastErrorMessage], sql);
	}

	returnCode = sqlite3_finalize(statement);

	GCEgoDBLockLog(@"%@ released lock", [sql md5]);
	[executeLock unlock];
	
	return (returnCode == SQLITE_OK);
}

- (sqlite3_int64)last_insert_rowid {
	if (handle) {
		return sqlite3_last_insert_rowid(handle);
	} else {
		GCEgoDBDebugLog(@"[EGODatabase] Can't get last rowid of nil sqlite");
		return 0;
	}
}

- (GCDatabaseResult*)executeQueryWithParameters:(NSString*)sql,... {
	return [self executeQuery:sql parameters:VAToArray(sql)];
}

- (GCDatabaseResult*)executeQuery:(NSString*)sql {
	return [self executeQuery:sql parameters:nil];
}

- (GCDatabaseResult*)executeQuery:(NSString*)sql parameters:(NSArray*)parameters {
	GCEgoDBLockLog(@"[Query] Waiting for Lock (%@): %@", [sql md5], sql);
	[executeLock lock];
	GCEgoDBLockLog(@"[Query] Got Lock (%@)", [sql md5]);
	
	GCDatabaseResult* result = [[GCDatabaseResult alloc] init];

	if(![self open]) {
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return result;
	}
	
	int returnCode = 0;
	sqlite3_stmt* statement = NULL;
	
	returnCode = sqlite3_prepare(handle, [sql UTF8String], -1, &statement, 0);
	result.errorCode = [self lastErrorCode];
	result.errorMessage = [self lastErrorMessage];
	
	if (SQLITE_BUSY == returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] Query Failed, Database Busy:\n%@\n\n", sql);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return result;
	} else if (SQLITE_OK != returnCode) {
		GCEgoDBDebugLog(@"[GCDatabase] Query Failed, Error: %d \"%@\"\n%@\n\n", [self lastErrorCode], [self lastErrorMessage], sql);
		sqlite3_finalize(statement);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return result;
	}
	
	if (![self bindStatement:statement toParameters:parameters]) {
		GCEgoDBDebugLog(@"[GCDatabase] Invalid bind cound for number of arguments.");
		sqlite3_finalize(statement);
		GCEgoDBLockLog(@"%@ released lock", [sql md5]);
		[executeLock unlock];
		return result;
	}
	
	int columnCount = sqlite3_column_count(statement);
	int x;
	
	for(x=0;x<columnCount;x++) {
		if(sqlite3_column_name(statement,x) != NULL) {
			[result.columnNames addObject:[NSString stringWithUTF8String:sqlite3_column_name(statement,x)]];
		} else {
			[result.columnNames addObject:[NSString stringWithFormat:@"%d", x]];
		}

		if(sqlite3_column_decltype(statement,x) != NULL) {
			[result.columnTypes addObject:[NSString stringWithUTF8String:sqlite3_column_decltype(statement,x)]];
		} else {
			[result.columnTypes addObject:@""];
		}
	}
	
	while(sqlite3_step(statement) == SQLITE_ROW) {
		GCDatabaseRow* row = [[GCDatabaseRow alloc] initWithDatabaseResult:result];
		for(x=0;x<columnCount;x++) {
            
//			if(sqlite3_column_text(statement,x) != NULL) {
//				[row.columnData addObject:[[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement,x)] autorelease]];
//			} else {
//				[row.columnData addObject:@""];
//			}
            
			if (SQLITE_BLOB == sqlite3_column_type(statement, x)) {
				[row.columnData addObject:[NSData
                                           dataWithBytes:sqlite3_column_text(statement,x)
                                           length:sqlite3_column_bytes(statement,x)]];
			} else if (sqlite3_column_text(statement,x) != NULL) {
				[row.columnData addObject:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement,x)]];
			} else {
				[row.columnData addObject:@""];
			}
            
		}
		
		[result addRow:row];
	}
	
	sqlite3_finalize(statement);

	GCEgoDBLockLog(@"%@ released lock", [sql md5]);
	[executeLock unlock];

	return result;
}

- (NSString*)lastErrorMessage {
	if([self hadError]) {
		return [NSString stringWithUTF8String:sqlite3_errmsg(handle)];
	} else {
		return nil;
	}
}

- (BOOL)hadError {
	return [self lastErrorCode] != SQLITE_OK;
}

- (int)lastErrorCode {
	return sqlite3_errcode(handle);
}

- (BOOL)bindStatement:(sqlite3_stmt*)statement toParameters:(NSArray*)parameters {
	int index = 0;
	int queryCount = sqlite3_bind_parameter_count(statement);
	
	for(id obj in parameters) {
		index++;
		[self bindObject:obj toColumn:index inStatement:statement];
	}
	
	return index == queryCount;
}

- (void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt {
	if ((!obj) || ((NSNull *)obj == [NSNull null])) {
		sqlite3_bind_null(pStmt, idx);
	} else if ([obj isKindOfClass:[NSData class]]) {
		sqlite3_bind_blob(pStmt, idx, [obj bytes], [obj length], SQLITE_STATIC);
	} else if ([obj isKindOfClass:[NSDate class]]) {
		sqlite3_bind_double(pStmt, idx, [obj timeIntervalSince1970]);
	} else if ([obj isKindOfClass:[NSNumber class]]) {
		if (strcmp([obj objCType], @encode(BOOL)) == 0) {
			sqlite3_bind_int(pStmt, idx, ([obj boolValue] ? 1 : 0));
		} else if (strcmp([obj objCType], @encode(int)) == 0) {
			sqlite3_bind_int64(pStmt, idx, [obj longValue]);
		} else if (strcmp([obj objCType], @encode(long)) == 0) {
			sqlite3_bind_int64(pStmt, idx, [obj longValue]);
		} else if (strcmp([obj objCType], @encode(float)) == 0) {
			sqlite3_bind_double(pStmt, idx, [obj floatValue]);
		} else if (strcmp([obj objCType], @encode(double)) == 0) {
			sqlite3_bind_double(pStmt, idx, [obj doubleValue]);
		} else {
			sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
		}
	} else {
		sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
	}
}

- (void)dealloc {
	[self close];
}

@end
