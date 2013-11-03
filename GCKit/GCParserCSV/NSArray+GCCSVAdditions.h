//
//  NSArray+GCCSVAdditions.h
//  GCCSVParser

#import <Foundation/Foundation.h>


@interface NSArray (GCCSVAdditions)

+ (id) arrayWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error;

+ (id) arrayWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error;
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error;
- (id) initWithContentsOfCSVStream:(NSInputStream *)csvStream usedEncoding:(NSStringEncoding *)usedEncoding delimiter:(NSString *)delimiter error:(NSError **)error;

+ (id) arrayWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVFile:(NSString *)csvFile encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error;

+ (id) arrayWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error;
- (id) initWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding error:(NSError **)error;
- (id) initWithContentsOfCSVFile:(NSString *)csvFile usedEncoding:(NSStringEncoding *)usedEncoding delimiter:(NSString *)delimiter error:(NSError **)error;

+ (id) arrayWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding error:(NSError **)error;
- (id) initWithContentsOfCSVString:(NSString *)csvString encoding:(NSStringEncoding)encoding delimiter:(NSString *)delimiter error:(NSError **)error;

- (BOOL) writeToCSVFile:(NSString *)csvFile atomically:(BOOL)atomically error:(NSError **)error;
- (BOOL) writeToCSVFile:(NSString *)csvFile withDelimiter:(NSString *)delimiter atomically:(BOOL)atomically error:(NSError **)error;

- (NSString *) CSVString;
- (NSString *) CSVStringWithDelimiter:(NSString *)delimiter error:(NSError **)error;

@end
