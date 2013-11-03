//
//  GCCSV.h
//  GCCSVParser

#import "GCParserCSV.h"
#import "GCWriterCSV.h"
#import "NSArray+GCCSVAdditions.h"
#import "NSString+GCCSVAdditions.h"

extern NSString *const GCCSVErrorDomain;

enum {
    GCCSVErrorCodeGeneric = 0,
    GCCSVErrorCodeInvalidStream,
    GCCSVErrorCodeInvalidFormat,
    GCCSVErrorCodeParsingCancelled
};

typedef NSInteger GCCSVErrorCode;
