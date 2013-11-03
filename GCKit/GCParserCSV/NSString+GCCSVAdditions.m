//
//  NSString+GCCSVAdditions.m
//  GCCSVParser

#import "GCCSV.h"

@implementation NSString (GCCSVAdditions)

- (NSArray *) CSVComponents {
	return [NSArray arrayWithContentsOfCSVString:self encoding:[self fastestEncoding] error:nil];
}

@end
