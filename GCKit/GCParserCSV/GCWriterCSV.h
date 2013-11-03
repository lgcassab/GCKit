//
//  GCCSVWriter.h
//  GCCSVParser

#import <Foundation/Foundation.h>


@interface GCWriterCSV : NSObject {
	NSString * destinationFile;
	NSString * handleFile;
	NSFileHandle * outputHandle;
	BOOL atomically;
    NSMutableString *stringValue;
	BOOL hasStarted;
	
	NSUInteger currentField;
	NSStringEncoding encoding;
	NSString *delimiter;
	
	NSCharacterSet * illegalCharacters;
	
	NSError * error;
}

@property (nonatomic) NSStringEncoding encoding; //defaults to NSUTF8StringEncoding
@property (nonatomic, copy) NSString *delimiter; //defaults to ,

- (id) initWithCSVFile:(NSString *)outputFile atomic:(BOOL)atomicWrite;

- (id) initForWritingToString;
- (NSString *) stringValue;

- (NSError *) error;

- (void) writeField:(id)field;
- (void) writeFields:(id)field, ... NS_REQUIRES_NIL_TERMINATION;

- (void) writeLine;
- (void) writeLineOfFields:(id)field, ... NS_REQUIRES_NIL_TERMINATION;
- (void) writeLineWithFields:(NSArray *)fields;

- (void) writeCommentLine:(id)comment;

- (void) closeFile;

@end
