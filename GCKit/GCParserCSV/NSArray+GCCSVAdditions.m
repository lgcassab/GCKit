//
//  NSArray+GCCSVAdditions.m
//  GCCSVParser

#import "GCCSV.h"

#pragma mark Support

@interface NSArrayGCCSVAggregator : NSObject <GCCSVParserDelegate> {
	NSMutableArray * lines;
	NSMutableArray * currentLine;
	NSError * error;
}

@property (readonly) NSArray * lines;
@property (readonly) NSError * error;

@end

@implementation NSArrayGCCSVAggregator
@synthesize lines, error;

- (void) dealloc {
	[lines release];
	[currentLine release];
	[error release];
	[super dealloc];
}

- (void) parser:(GCParserCSV *)parser didStartDocument:(NSString *)csvFile {
	lines = [[NSMutableArray alloc] init];
}

- (void) parser:(GCParserCSV *)parser didStartLine:(NSUInteger)lineNumber {
	currentLine = [[NSMutableArray alloc] init];
}

- (void) parser:(GCParserCSV *)parser didEndLine:(NSUInteger)lineNumber {
	if ([currentLine count] > 0) {
		[lines addObject:currentLine];
	}
	[currentLine release], currentLine = nil;
}

- (void) parser:(GCParserCSV *)parser didReadField:(NSString *)field {
	[currentLine addObject:field];
}

- (void) parser:(GCParserCSV *)parser didEndDocument:(NSString *)csvFile {
	
}

- (void) parser:(GCParserCSV *)parser didFailWithError:(NSError *)anError {
	error = [anError retain];
}

@end

#pragma mark NSArray Category

@implementation NSArray (GCCSVAdditions)

+ (id) arrayWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding error:(NSError **)error {
    return [[[self alloc] initWithContentsOfCSVStream:csvStream encoding:encoding error:error] autorelease];
}
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding error:(NSError **)error {
    return [self initWithContentsOfCSVStream:csvStream encoding:encoding delimiter:@"," error:error];
}
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error {
    return [self initWithContentsOfCSVStream:csvStream usedEncoding:&encoding delimiter:delimiter error:error];
}

+ (id) arrayWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error {
    return [[[self alloc] initWithContentsOfCSVStream:csvStream usedEncoding:usedEncoding error:error] autorelease];
}
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error {
    return [self initWithContentsOfCSVStream:csvStream usedEncoding:usedEncoding delimiter:@"," error:error];
}
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding delimiter:(NSString *)delimiter error:(NSError **)error {
    //THIS IS THE "DESIGNATED" INITIALIZER
    //all other CSV initializers run through this one
    
    GCParserCSV *parser = [[GCParserCSV alloc] initWithStream:csvStream usedEncoding:usedEncoding error:error];
	[parser setDelimiter:delimiter];
	NSArrayGCCSVAggregator * delegate = [[NSArrayGCCSVAggregator alloc] init];
	[parser setParserDelegate:delegate];
	
	[parser parse];
	
	NSArray * lines = [[[delegate lines] retain] autorelease];
	NSError * parserError = [[[delegate error] retain] autorelease];
	
	[delegate release];
	[parser release];
	
	if (parserError) {
		if (error) {
			*error = parserError;
		}
		[self release];
		return nil;
	}
	return [self initWithArray:lines];
}

+ (id) arrayWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding error:(NSError **)error {
	return [[[self alloc] initWithContentsOfCSVFile:csvFile encoding:encoding error:error] autorelease];
}

- (id) initWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding error:(NSError **)error {
	return [self initWithContentsOfCSVFile:csvFile encoding:encoding delimiter:@"," error:error];
}

- (id) initWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error {
    NSInputStream *csvStream = [NSInputStream inputStreamWithFileAtPath:csvFile];
    return [self initWithContentsOfCSVStream:csvStream encoding:encoding delimiter:delimiter error:error];
}

+ (id) arrayWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error {
	return [[[self alloc] initWithContentsOfCSVFile:csvFile usedEncoding:usedEncoding error:error] autorelease];
}

- (id) initWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error {
	return [self initWithContentsOfCSVFile:csvFile usedEncoding:usedEncoding delimiter:@"," error:error];
}

- (id) initWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding delimiter:(NSString *)delimiter error:(NSError **)error {
    NSInputStream *csvStream = [NSInputStream inputStreamWithFileAtPath:csvFile];
    return [self initWithContentsOfCSVStream:csvStream usedEncoding:usedEncoding delimiter:delimiter error:error];
}

+ (id) arrayWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)error {
	return [[[self alloc] initWithContentsOfCSVString:csvString encoding:encoding error:error] autorelease];
}

- (id) initWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)error {
	return [self initWithContentsOfCSVString:csvString encoding:encoding delimiter:@"," error:error];
}

- (id) initWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error {
    NSInputStream *csvStream = [NSInputStream inputStreamWithData:[csvString dataUsingEncoding:encoding]];
    return [self initWithContentsOfCSVStream:csvStream encoding:encoding delimiter:delimiter error:error];
}

- (BOOL) writeToCSVFile:(NSString *)csvFile atomically:(BOOL)atomically error:(NSError **)error {
	return [self writeToCSVFile:csvFile withDelimiter:@"," atomically:atomically error:error];
}

- (BOOL) writeToCSVFile:(NSString *)csvFile withDelimiter:(NSString *)delimiter atomically:(BOOL)atomically error:(NSError **)error {
	//first, verify that this is (at least) an NSArray of NSArrays:
	for (id object in self) {
		if ([object isKindOfClass:[NSArray class]] == NO) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeInvalidFormat userInfo:[NSDictionary dictionaryWithObject:@"Invalid array structure" forKey:NSLocalizedDescriptionKey]];
            }
            return NO;
        }
	}
	
	BOOL ok = YES;
	
	GCWriterCSV * writer = [[GCWriterCSV alloc] initWithCSVFile:csvFile atomic:atomically];
	[writer setDelimiter:delimiter];
	for (NSArray * row in self) {
		[writer writeLineWithFields:row];
	}
	
	ok = ([writer error] == nil);
	if (!ok && error) {
		*error = [[[writer error] retain] autorelease];
	}
	[writer closeFile];
	[writer release];
	
	return ok;
}

- (NSString *) CSVString {
    NSError *error = nil;
    return [self CSVStringWithDelimiter:@"," error:&error];
}

- (NSString *) CSVStringWithDelimiter:(NSString *)delimiter error:(NSError **)error {
    GCWriterCSV *writer = [[GCWriterCSV alloc] initForWritingToString];
    [writer setDelimiter:delimiter];
    for (NSArray *array in self) {
        [writer writeLineWithFields:array];
    }
    NSString *string = [writer stringValue];
    if (!string && error) {
        *error = [[[writer error] retain] autorelease];
    }
    [writer release];
    return string;
}

@end
