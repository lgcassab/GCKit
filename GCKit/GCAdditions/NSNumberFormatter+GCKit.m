//
//  NSNumberFormatter+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/11.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.

#import "NSNumberFormatter+GCKit.h"

@implementation NSNumberFormatter (GCKit)

+ (NSNumberFormatter *)brazilianNumberFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BT"]];
    [formatter setDecimalSeparator:@","];
    [formatter setGeneratesDecimalNumbers:TRUE];
    [formatter setMinimumFractionDigits:2];
    [formatter setMaximumFractionDigits:2];
    return formatter;
}

@end
