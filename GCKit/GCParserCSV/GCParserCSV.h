//
//  GCCSVParser.h
//  GCCSVParser

#import <Foundation/Foundation.h>

@protocol GCCSVParserDelegate;

@interface GCParserCSV : NSObject {

	@private
	__weak id<GCCSVParserDelegate> parserDelegate;
    NSInputStream *csvReadStream;
	BOOL endOfStreamReached;
	NSStringEncoding fileEncoding;
    
	NSString *csvFile;
	
	BOOL hasStarted;
	NSString *delimiter;
	unichar delimiterCharacter;
	
	NSMutableData *currentChunk;
	NSMutableString *currentChunkString;
	NSUInteger stringIndex;
	
	BOOL balancedQuotes;
	BOOL balancedEscapes;
	
	NSMutableString *currentField;
	NSUInteger currentLine;
	
	NSUInteger state;
	NSError *error;
}

@property (assign) id<GCCSVParserDelegate> parserDelegate;
@property (readonly) NSError * error;
@property (readonly) NSString * csvFile;
@property (nonatomic, copy) NSString *delimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithStream:(NSInputStream *)readStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)anError; //designated initializer
- (id) initWithStream:(NSInputStream *)readStream encoding:(NSStringEncoding)encoding error:(NSError **)anError;

- (id) initWithContentsOfCSVFile:(NSString *)aCSVFile encoding:(NSStringEncoding)encoding error:(NSError **)anError;
- (id) initWithContentsOfCSVFile:(NSString *)aCSVFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)anError;

- (id) initWithCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)anError;

- (void) parse;
- (void) cancelParsing;

@end

@protocol GCCSVParserDelegate <NSObject>

- (void) parser:(GCParserCSV *)parser didStartDocument:(NSString *)csvFile;
- (void) parser:(GCParserCSV *)parser didStartLine:(NSUInteger)lineNumber;

- (void) parser:(GCParserCSV *)parser didEndLine:(NSUInteger)lineNumber;

- (void) parser:(GCParserCSV *)parser didReadField:(NSString *)field;

- (void) parser:(GCParserCSV *)parser didEndDocument:(NSString *)csvFile;

- (void) parser:(GCParserCSV *)parser didFailWithError:(NSError *)error;

@end
