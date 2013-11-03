//
//  GCValidator.m
//  GCKit
//
//  Created by Gustavo Cassab on 03/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCValidator.h"

@implementation GCValidator

+ (BOOL)validateEmail:(NSString *)emailString {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}

+ (BOOL)validateCPF:(NSString *)cpf {
    
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(cpf == nil)
        return NO;
    
    if ([cpf length] != 11)
        return NO;
    
    //    Esse monte de expressão lógica de repetição podem ser substituídas por um RegEx:
    //    NSError *error = NULL;
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d)\\1+" options:0 error:&error];
    //    NSUInteger numberOfMatches = [regex numberOfMatchesInString:searchText options:0 range:NSMakeRange(0, [string length])];
    
    if (([cpf isEqual:@"00000000000"]) || ([cpf isEqual:@"11111111111"]) || ([cpf isEqual:@"22222222222"])|| ([cpf isEqual:@"33333333333"])|| ([cpf isEqual:@"44444444444"])|| ([cpf isEqual:@"55555555555"])|| ([cpf isEqual:@"66666666666"])|| ([cpf isEqual:@"77777777777"])|| ([cpf isEqual:@"88888888888"])|| ([cpf isEqual:@"99999999999"]))
        return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[cpf substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[cpf substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    
    return NO;
}

+ (BOOL)validateBirthDate:(NSString *)birthDate {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dt = [df dateFromString:birthDate];
    
    // Data com formato inválido
    if (!dt)
        return NO;
    
    // Data superior a hoje
    if ([dt earlierDate:[NSDate date]] != dt)
        return NO;
    
    // Data inferior a 1900
    NSDate *dt1900 = [df dateFromString:@"01/01/1900"];
    if ([dt earlierDate:dt1900] == dt)
        return NO;
    
    return YES;
}

+ (BOOL)validateUrl:(NSString *)url {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:url];
}

+ (BOOL)validatePhone:(NSString *)phone {
    
    if (!phone)
        return NO;
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    NSDataDetector *matchdetector = [NSDataDetector dataDetectorWithTypes:(uint64_t)NSTextCheckingTypePhoneNumber
                                                                    error:&error];
    NSUInteger matchNumber = [matchdetector numberOfMatchesInString:phone
                                                            options:0
                                                              range:NSMakeRange(0, [phone length])];
    if (matchNumber > 0)
        isValid = YES;
    
    return isValid;
}

@end
