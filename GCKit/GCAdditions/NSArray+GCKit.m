//
//  NSArray+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "NSArray+GCKit.h"

@implementation NSArray (GCKit)

+ (NSArray *)arrayWithBrazilianStates {
    return @[@"AC",
			 @"AL",
			 @"AM",
			 @"AP",
			 @"BA",
			 @"CE",
			 @"DF",
			 @"ES",
			 @"GO",
			 @"MA",
			 @"MG",
			 @"MS",
			 @"MT",
			 @"PA",
			 @"PB",
			 @"PE",
			 @"PI",
			 @"PR",
			 @"RJ",
			 @"RN",
			 @"RO",
			 @"RR",
			 @"RS",
			 @"SC",
			 @"SE",
			 @"SP",
			 @"TO"];
}

- (NSArray *)splitWithRange:(NSUInteger)splitRange {
	NSUInteger totalCount = [self count];
    NSUInteger currentIndex = 0;
	
    NSMutableArray *splitArray = [NSMutableArray new];
    while (currentIndex < totalCount) {
        NSRange range = NSMakeRange(currentIndex, MIN(splitRange, totalCount-currentIndex));
        NSArray *subArray = [self subarrayWithRange:range];
        [splitArray addObject:subArray];
        currentIndex += splitRange;
    }
	
    return splitArray;
}

@end
