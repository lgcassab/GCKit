//
//  GCCSVParser.m
//  GCCSVParser

#import "GCCSV.h"
#define STRING_QUOTE @"\""
#define STRING_BACKSLASH @"\\"

#define UNICHAR_QUOTE '"'
#define UNICHAR_BACKSLASH '\\'

NSString *const GCCSVErrorDomain = @"com.davedelong.csv";

enum {
	GCCSVParserStateInsideFile = 0,
	GCCSVParserStateInsideLine = 1,
	GCCSVParserStateInsideField = 2,
	GCCSVParserStateInsideComment = 3,
    GCCSVParserStateCancelled = 4
};

@interface NSMutableString (GCCSVAdditions)

- (void) trimString_csv:(NSString *)character;
- (void) trimCharactersInSet_csv:(NSCharacterSet *)set;
- (void) replaceOccurrencesOfString:(NSString *)find withString_csv:(NSString *)replace;

@end

@implementation NSMutableString (GCCSVAdditions)

- (void) trimString_csv:(NSString *)character {
	[self replaceCharactersInRange:NSMakeRange(0, [character length]) withString:@""];
	[self replaceCharactersInRange:NSMakeRange([self length] - [character length], [character length]) withString:@""];
}

- (void) trimCharactersInSet_csv:(NSCharacterSet *)set {
	NSString *trimmed = [self stringByTrimmingCharactersInSet:set];
	[self setString:trimmed];
}

- (void) replaceOccurrencesOfString:(NSString *)find withString_csv:(NSString *)replace {
	[self replaceOccurrencesOfString:find withString:replace options:NSLiteralSearch range:NSMakeRange(0, [self length])];
}

@end

@interface GCParserCSV ()

@property (retain) NSMutableData *currentChunk;

- (NSStringEncoding) textEncodingForData:(NSData *)chunkToSniff offset:(NSUInteger *)offset;

- (void) determineTextEncoding;
- (void) extractStringFromCurrentChunk;
- (void) readNextChunk;
- (NSString *) nextCharacter;
- (void) runParseLoop;
- (void) processComposedCharacter:(NSString *)currentCharacter previousCharacter:(NSString *)previousCharacter previousPreviousCharacter:(NSString *)previousPreviousCharacter;

- (void) beginCurrentLine;
- (void) beginCurrentField;
- (void) finishCurrentField;
- (void) finishCurrentLine;

@end

#define SETSTATE(_s) if (state != GCCSVParserStateCancelled) { state = _s; }

@implementation GCParserCSV
@synthesize parserDelegate, currentChunk, error, csvFile, delimiter, chunkSize;

- (id) initWithStream:(NSInputStream *)readStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)anError {
    self = [super init];
    if (self) {
        csvReadStream = [readStream retain];
        [csvReadStream open];
        
        NSStreamStatus status = [csvReadStream streamStatus];
        if (status != NSStreamStatusOpening &&
            status != NSStreamStatusOpen &&
            status != NSStreamStatusReading) {
            if (anError) {
                *anError = [NSError errorWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeInvalidStream userInfo:[NSDictionary dictionaryWithObject:@"Unable to open file for reading" forKey:NSLocalizedDescriptionKey]];
            }
            [self release];
            return nil;
        }
		
        chunkSize = 2048;
        
		balancedQuotes = YES;
		balancedEscapes = YES;
		
		currentLine = 0;
		currentField = [[NSMutableString alloc] init];
		
        if (currentChunk == nil) {
            currentChunk = [[NSMutableData alloc] init];
        }
		endOfStreamReached = NO;
        currentChunkString = [[NSMutableString alloc] init];
		stringIndex = 0;
		
		[self setDelimiter:@","];
		
        SETSTATE(GCCSVParserStateInsideFile)
        
        if (usedEncoding && *usedEncoding > 0) {
            //if we're supplied an encoding, just use that
            fileEncoding = *usedEncoding;
        } else {
            //otherwise try to guess
            [self determineTextEncoding];
        }
        if (usedEncoding) {
            *usedEncoding = fileEncoding;
        }
        
    }
    return self;
}

- (id)initWithStream:(NSInputStream *)readStream encoding:(NSStringEncoding)encoding error:(NSError **)anError {
    return [self initWithStream:readStream usedEncoding:&encoding error:anError];
}

- (id) initWithContentsOfCSVFile:(NSString *)aCSVFile encoding:(NSStringEncoding)encoding error:(NSError **)anError {
    return [self initWithContentsOfCSVFile:aCSVFile usedEncoding:&encoding error:anError];
}

- (id) initWithContentsOfCSVFile:(NSString *)aCSVFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)anError {
    NSInputStream *readStream = [NSInputStream inputStreamWithFileAtPath:aCSVFile];
    
    self = [self initWithStream:readStream usedEncoding:usedEncoding error:anError];
	if (self) {
		csvFile = [aCSVFile copy];
	}
	return self;
}

- (id) initWithCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)anError {
    return [self initWithStream:[NSInputStream inputStreamWithData:[csvString dataUsingEncoding:encoding]]
                       encoding:encoding
                          error:anError];
}

- (void) dealloc {
    [csvReadStream close];
	[csvReadStream release];
	[csvFile release];
	[currentField release];
	[currentChunk release];
	[currentChunkString release];
	[error release];
	[delimiter release];
	
	[super dealloc];
}

- (void) determineTextEncoding {
    uint8_t *bytes = calloc([self chunkSize], sizeof(uint8_t));
    NSUInteger bytesRead = [csvReadStream read:bytes maxLength:[self chunkSize]];
    [currentChunk appendBytes:bytes length:bytesRead];
    
    if ([currentChunk length] > 0) {
        NSUInteger offset = 0;
        fileEncoding = [self textEncodingForData:currentChunk offset:&offset];
        if (offset > 0) {
            // strip off the text encoding bytes
            [currentChunk replaceBytesInRange:NSMakeRange(0, offset) withBytes:NULL length:0];
        }
        [self extractStringFromCurrentChunk];
    }
    free(bytes);
}

- (NSStringEncoding) textEncodingForData:(NSData *)chunkToSniff offset:(NSUInteger *)offset {
	NSUInteger length = [chunkToSniff length];
	*offset = 0;
	NSStringEncoding encoding = NSUTF8StringEncoding;
	
	if (length > 0) {
		UInt8* bytes = (UInt8*)[chunkToSniff bytes];
		encoding = CFStringConvertEncodingToNSStringEncoding(CFStringGetSystemEncoding());
		switch (bytes[0]) {
			case 0x00:
				if (length>3 && bytes[1]==0x00 && bytes[2]==0xFE && bytes[3]==0xFF) {
					encoding = NSUTF32BigEndianStringEncoding;
					*offset = 4;
				}
				break;
			case 0xEF:
				if (length>2 && bytes[1]==0xBB && bytes[2]==0xBF) {
					encoding = NSUTF8StringEncoding;
					*offset = 3;
				}
				break;
			case 0xFE:
				if (length>1 && bytes[1]==0xFF) {
					encoding = NSUTF16BigEndianStringEncoding;
					*offset = 2;
				}
				break;
			case 0xFF:
				if (length>1 && bytes[1]==0xFE) {
					if (length>3 && bytes[2]==0x00 && bytes[3]==0x00) {
						encoding = NSUTF32LittleEndianStringEncoding;
						*offset = 4;
					} else {
						encoding = NSUTF16LittleEndianStringEncoding;
						*offset = 2;
					}
				}
				break;
			default:
				if ([[[NSString alloc] initWithData:chunkToSniff encoding:NSUTF8StringEncoding] autorelease] == nil) {
					NSLog(@"unable to determine file encoding; assuming MacOSRoman");
					encoding = NSMacOSRomanStringEncoding;
				} else {
					NSLog(@"unable to determine file encoding; assuming UTF8");
					encoding = NSUTF8StringEncoding; // fall back on UTF8
				}
				break;
		}
	}
	
	return encoding;
}

- (void) setDelimiter:(NSString *)newDelimiter {
	if (hasStarted) {
		[NSException raise:NSInvalidArgumentException format:@"You cannot set a delimiter after parsing has started"];
		return;
	}
	
	// the delimiter cannot be
	BOOL shouldThrow = ([newDelimiter length] != 1);
	if ([[NSCharacterSet newlineCharacterSet] characterIsMember:[newDelimiter characterAtIndex:0]]) {
		shouldThrow = YES;
	}
	if ([newDelimiter hasPrefix:@"#"]) { shouldThrow = YES; }
	if ([newDelimiter hasPrefix:@"\""]) { shouldThrow = YES; }
	if ([newDelimiter hasPrefix:@"\\"]) { shouldThrow = YES; }
	
	if (shouldThrow) {
		[NSException raise:NSInvalidArgumentException format:@"%@ cannot be used as a delimiter", newDelimiter];
		return;
	}
	
	if (newDelimiter != delimiter) {
		[delimiter release];
		delimiter = [newDelimiter copy];
		delimiterCharacter = [delimiter characterAtIndex:0];
	}
}

#pragma mark Parsing methods

- (void)extractStringFromCurrentChunk {
    
    NSUInteger readLength = [currentChunk length];
    do {
        NSString *readString = [[NSString alloc] initWithBytes:[currentChunk bytes] length:readLength encoding:fileEncoding];
        if (readString == nil) {
            readLength--;
            if (readLength == 0) {
                error = [[NSError alloc] initWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeInvalidStream userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                               @"unable to interpret current chunk as a string", NSLocalizedDescriptionKey,
                                                                                               nil]];
                break;
            }
        } else {
            [currentChunkString appendString:readString];
            [readString release];
            break;
        }
    } while (1);
    
    
    [currentChunk replaceBytesInRange:NSMakeRange(0, readLength) withBytes:NULL length:0];
}

- (void) readNextChunk {
    NSData *nextChunk = nil;
    uint8_t *bytes = calloc([self chunkSize], sizeof(uint8_t));
    @try {
        NSInteger bytesRead = [csvReadStream read:bytes maxLength:[self chunkSize]];
        if (bytesRead >= 0) {
            nextChunk = [NSData dataWithBytes:bytes length:bytesRead];
        } else {
            //bytesRead < 0
            error = [[NSError alloc] initWithDomain:GCCSVErrorDomain 
                                               code:GCCSVErrorCodeInvalidStream 
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     @"Unable to read from input stream", NSLocalizedDescriptionKey,
                                                     [csvReadStream streamError], NSUnderlyingErrorKey,
                                                     nil]];
        }
    }
    @catch (NSException *e) {
        error = [[NSError alloc] initWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeInvalidStream userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                       e, NSUnderlyingErrorKey,
                                                                                       [e reason], NSLocalizedDescriptionKey,
                                                                                       nil]];
        nextChunk = nil;
    }
    free(bytes);
    
    if ([nextChunk length] > 0) {
        // we were able to read something!
        [currentChunk appendData:nextChunk];
        
        [self extractStringFromCurrentChunk];
    }
    if ([csvReadStream streamStatus] == NSStreamStatusAtEnd) {
        endOfStreamReached = YES;
    }
}

- (NSString *) nextCharacter {
	if (endOfStreamReached == NO && stringIndex >= [currentChunkString length]/2) {
        [self readNextChunk];
	}
	
	if (stringIndex >= [currentChunkString length]) { return nil; }
	if ([currentChunkString length] == 0) { return nil; }
	
	NSRange charRange = [currentChunkString rangeOfComposedCharacterSequenceAtIndex:stringIndex];
	NSString *nextChar = [currentChunkString substringWithRange:charRange];
	stringIndex = charRange.location + charRange.length;
	return nextChar;
}

- (void) parse {
	hasStarted = YES;
	[[self parserDelegate] parser:self didStartDocument:[self csvFile]];
	
	[self runParseLoop];
	
	if (error != nil) {
		[[self parserDelegate] parser:self didFailWithError:error];
	} else {
		[[self parserDelegate] parser:self didEndDocument:[self csvFile]];
	}
	hasStarted = NO;
}

- (void) runParseLoop {
	NSString *currentCharacter = nil;
	NSString *previousCharacter = nil;
	NSString *previousPreviousCharacter = nil;
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	unsigned char counter = 0;
	
	while (error == nil && 
		   (currentCharacter = [self nextCharacter]) && 
		   currentCharacter != nil) {
		[self processComposedCharacter:currentCharacter previousCharacter:previousCharacter previousPreviousCharacter:previousPreviousCharacter];
        
        if (state == GCCSVParserStateCancelled) { break; }
        
		previousPreviousCharacter = previousCharacter;
		previousCharacter = currentCharacter;
		
		counter++;
		if (counter == 0) { //this happens every 256 (2**8) iterations when the unsigned short overflows
			[currentCharacter retain];
			[previousCharacter retain];
			[previousPreviousCharacter retain];
			
			[pool drain];
			pool = [[NSAutoreleasePool alloc] init];
			
			[currentCharacter autorelease];
			[previousCharacter autorelease];
			[previousPreviousCharacter autorelease];
		}
	}
	
	[pool drain];
	
	if ([currentField length] > 0 && state == GCCSVParserStateInsideField) {
		[self finishCurrentField];
	}
	if (state == GCCSVParserStateInsideLine) {
		[self finishCurrentLine];
	}
}

- (void) processComposedCharacter:(NSString *)currentCharacter previousCharacter:(NSString *)previousCharacter previousPreviousCharacter:(NSString *)previousPreviousCharacter {
	if (state == GCCSVParserStateInsideFile) {
		//this is the "beginning of the line" state
		//this is also where we determine if we should ignore this line (it's a comment)
		if ([currentCharacter isEqual:@"#"] == NO) {
			[self beginCurrentLine];
		} else {
            SETSTATE(GCCSVParserStateInsideComment)
		}
	}
	
	unichar currentUnichar = [currentCharacter characterAtIndex:0];
	unichar previousUnichar = [previousCharacter characterAtIndex:0];
	unichar previousPreviousUnichar = [previousPreviousCharacter characterAtIndex:0];
	
	if (currentUnichar == UNICHAR_QUOTE) {
		if (state == GCCSVParserStateInsideLine) {
			//beginning a quoted field
			[self beginCurrentField];
			balancedQuotes = NO;
		} else if (state == GCCSVParserStateInsideField) {
			if (balancedEscapes == NO) {
				balancedEscapes = YES;
			} else {
				balancedQuotes = !balancedQuotes;
			}
		}
	} else if (currentUnichar == delimiterCharacter) {
		if (state == GCCSVParserStateInsideLine) {
			[self beginCurrentField];
			[self finishCurrentField];
		} else if (state == GCCSVParserStateInsideField) {
			if (balancedEscapes == NO) {
				balancedEscapes = YES;
			} else if (balancedQuotes == YES) {
				[self finishCurrentField];
			}
		}
	} else if (currentUnichar == UNICHAR_BACKSLASH) {
		if (state == GCCSVParserStateInsideField) {
			balancedEscapes = !balancedEscapes;
		} else if (state == GCCSVParserStateInsideLine) {
			[self beginCurrentField];
			balancedEscapes = NO;
		}
	} else if ([[NSCharacterSet newlineCharacterSet] characterIsMember:currentUnichar] && [[NSCharacterSet newlineCharacterSet] characterIsMember:previousUnichar] == NO) {
		if (balancedQuotes == YES && balancedEscapes == YES) {
			if (state != GCCSVParserStateInsideComment) {
				[self finishCurrentField];
				[self finishCurrentLine];
			} else {
                SETSTATE(GCCSVParserStateInsideFile)
			}
		}
	} else {
		if (previousUnichar == UNICHAR_QUOTE && previousPreviousUnichar != UNICHAR_BACKSLASH && balancedQuotes == YES && balancedEscapes == YES) {
			NSString *reason = [NSString stringWithFormat:@"Invalid CSV format on line #%u immediately after \"%@\"", currentLine, currentField];
			error = [[NSError alloc] initWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeInvalidFormat userInfo:[NSDictionary dictionaryWithObject:reason forKey:NSLocalizedDescriptionKey]];
			return;
		}
		if (state != GCCSVParserStateInsideComment) {
			if (state != GCCSVParserStateInsideField) {
				[self beginCurrentField];
			}
            SETSTATE(GCCSVParserStateInsideField)
			if (balancedEscapes == NO) {
				balancedEscapes = YES;
			}
		}
	}
	
	if (state != GCCSVParserStateInsideComment) {
		[currentField appendString:currentCharacter];
	}
}

- (void) beginCurrentLine {
	currentLine++;
	[[self parserDelegate] parser:self didStartLine:currentLine];
    SETSTATE(GCCSVParserStateInsideLine)
}

- (void) beginCurrentField {
	[currentField setString:@""];
	balancedQuotes = YES;
	balancedEscapes = YES;
    SETSTATE(GCCSVParserStateInsideField)
}

- (void) finishCurrentField {
	[currentField trimCharactersInSet_csv:[NSCharacterSet newlineCharacterSet]];
	if ([currentField hasPrefix:STRING_QUOTE] && [currentField hasSuffix:STRING_QUOTE]) {
		[currentField trimString_csv:STRING_QUOTE];
	}
	if ([currentField hasPrefix:delimiter]) {
		[currentField replaceCharactersInRange:NSMakeRange(0, [delimiter length]) withString:@""];
	}
	
	[currentField trimCharactersInSet_csv:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	[currentField replaceOccurrencesOfString:@"\"\"" withString_csv:STRING_QUOTE];
	
	//replace all occurrences of regex: \\(.) with $1 (but not by using a regex)
	NSRange nextSlash = [currentField rangeOfString:STRING_BACKSLASH options:NSLiteralSearch range:NSMakeRange(0, [currentField length])];
	while(nextSlash.location != NSNotFound) {
		[currentField replaceCharactersInRange:nextSlash withString:@""];
		
		NSRange nextSearchRange = NSMakeRange(nextSlash.location + nextSlash.length, 0);
		nextSearchRange.length = [currentField length] - nextSearchRange.location;
        if (nextSearchRange.location >= [currentField length]) { break; }
		nextSlash = [currentField rangeOfString:STRING_BACKSLASH options:NSLiteralSearch range:nextSearchRange];
	}
	
	NSString *field = [currentField copy];
	[[self parserDelegate] parser:self didReadField:field];
	[field release];
	
	[currentField setString:@""];
	
    SETSTATE(GCCSVParserStateInsideLine)
}

- (void) finishCurrentLine {
	[[self parserDelegate] parser:self didEndLine:currentLine];
    SETSTATE(GCCSVParserStateInsideFile)
}

#pragma Cancelling

- (void) cancelParsing {
    SETSTATE(GCCSVParserStateCancelled)
    error = [[NSError alloc] initWithDomain:GCCSVErrorDomain code:GCCSVErrorCodeParsingCancelled userInfo:nil];
}

@end