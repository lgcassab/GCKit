//
//  GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCKit.h"

@implementation GCKit

static GCKit *sharedKit = nil;

+ (GCKit *)sharedKit {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedKit = [[GCKit alloc] init];
    });
    return sharedKit;
}

+ (id)alloc {
	NSAssert(sharedKit == nil, @"Attempted to allocate a second instance of GCKit.");
	return [super alloc];
}

-(id) init {
	
//	[GCActionManager sharedManager];
	NSLog(@"GCKit %@" , GCKitVersion);
    
//    if (iPadDevice)
//        [GCPopController sharedController];
    
//    [GCTextFieldDelegate sharedDelegate];
    
//    _gcMailComposer = nil;
    
	return self;
}

#pragma mark - Public Methods

- (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)openSiteInSafariWithUrlString:(NSString *)urlString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

//-(CGSize)screenSize {
//    return [UIScreen mainScreen].bounds.size;
//}

//-(void)showAlertFuncionalidadeNaoImplementada {
//    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Funcionalidade ainda não implementada"];
//}

//-(void)showAlertInternetNotAvailable {
//    [UIAlertView alertViewWithTitle:@"Atenção" message:@"Acesso a Internet não está disponível"];
//}

//-(BOOL)internetConnectionIsAvailable {
//	
//	BOOL retorno = YES;
//	
//	if ([[GCReachability reachabilityForInternetConnection] currentReachabilityStatus] == GCNotReachable) {
//		retorno = NO;
//	}
//	
//	return retorno;
//}


//-(void)alertUserReviewWithAppID:(NSString *)appID
//                          title:(NSString *)title
//                        message:(NSString *)message
//               buttonLaterTitle:(NSString *)buttonLaterTitle
//              buttonReviewTitle:(NSString *)buttonReviewTitle
//             buttonDisableTitle:(NSString *)buttonDisableTitle
//                         cicles:(int)cicles {
//    
//    BOOL desabilitado = [[NSUserDefaults standardUserDefaults] boolForKey:@"gcUserReviewDisabled"];
//	int count = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	count++;
//    
//    if (count == cicles && !desabilitado) {
//        
//        [UIAlertView alertViewWithTitle:title
//                                message:message
//                      cancelButtonTitle:buttonLaterTitle
//                      otherButtonTitles:[NSArray arrayWithObjects:buttonReviewTitle, buttonDisableTitle, nil]
//                              onDismiss:^(int buttonIndex) {
//                                  
//                                  switch (buttonIndex) {
//                                      case 0: {
//                                          
//                                          NSString *url = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&type=Purple+Software",appID];
//                                          
//                                          [self openSiteInSafariWithUrlString:url];
//                                          
//                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
//                                          [[NSUserDefaults standardUserDefaults] synchronize];
//                                          break;
//                                      }
//                                          
//                                      case 1: {
//                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gcUserReviewDisabled"];
//                                          [[NSUserDefaults standardUserDefaults] synchronize];
//                                          break;
//                                      }
//                                  }
//                                  
//                              }
//                               onCancel:^{}
//         ];
//        
//		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	} else {
//		[[NSUserDefaults standardUserDefaults] setInteger:count forKey:[NSString stringWithFormat:@"gcUserReviewAppID-%@" , appID]];
//	}
//	
//	[[NSUserDefaults standardUserDefaults] synchronize];
//}

//-(NSArray *)arrayWithEstadosBrasileiros {
//    NSArray *array = [NSArray arrayWithObjects:
//                      @"AC",
//                      @"AL",
//                      @"AM",
//                      @"AP",
//                      @"BA",
//                      @"CE",
//                      @"DF",
//                      @"ES",
//                      @"GO",
//                      @"MA",
//                      @"MG",
//                      @"MS",
//                      @"MT",
//                      @"PA",
//                      @"PB",
//                      @"PE",
//                      @"PI",
//                      @"PR",
//                      @"RJ",
//                      @"RN",
//                      @"RO",
//                      @"RR",
//                      @"RS",
//                      @"SC",
//                      @"SE",
//                      @"SP",
//                      @"TO",
//                      nil];
//    return array;
//}

#pragma mark - Validators

//-(BOOL)validateEmail:(NSString *)emailString {
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:emailString];
//}

//-(BOOL)validateCPF:(NSString *)cpf {
//    
//    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
//    if(cpf == nil)
//        return NO;
//    
//    if ([cpf length] != 11)
//        return NO;
//    
//    //    Esse monte de expressão lógica de repetição podem ser substituídas por um RegEx:
//    //    NSError *error = NULL;
//    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d)\\1+" options:0 error:&error];
//    //    NSUInteger numberOfMatches = [regex numberOfMatchesInString:searchText options:0 range:NSMakeRange(0, [string length])];
//    
//    if (([cpf isEqual:@"00000000000"]) || ([cpf isEqual:@"11111111111"]) || ([cpf isEqual:@"22222222222"])|| ([cpf isEqual:@"33333333333"])|| ([cpf isEqual:@"44444444444"])|| ([cpf isEqual:@"55555555555"])|| ([cpf isEqual:@"66666666666"])|| ([cpf isEqual:@"77777777777"])|| ([cpf isEqual:@"88888888888"])|| ([cpf isEqual:@"99999999999"]))
//        return NO;
//    
//    firstSum = 0;
//    for (i = 0; i <= 8; i++) {
//        firstSum += [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
//    }
//    
//    if (firstSum % 11 < 2)
//        firstDigit = 0;
//    else
//        firstDigit = 11 - (firstSum % 11);
//    
//    secondSum = 0;
//    for (i = 0; i <= 9; i++) {
//        secondSum = secondSum + [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
//    }
//    
//    if (secondSum % 11 < 2)
//        secondDigit = 0;
//    else
//        secondDigit = 11 - (secondSum % 11);
//    
//    firstDigitCheck = [[cpf substringWithRange:NSMakeRange(9, 1)] intValue];
//    secondDigitCheck = [[cpf substringWithRange:NSMakeRange(10, 1)] intValue];
//    
//    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
//        return YES;
//    
//    return NO;
//}

//-(BOOL)validateBirthDate:(NSString *)birthDate {
//    NSDateFormatter *df = [NSDateFormatter new];
//    [df setDateFormat:@"dd/MM/yyyy"];
//    
//    NSDate *dt = [df dateFromString:birthDate];
//    
//    // Data com formato inválido
//    if (!dt)
//        return NO;
//    
//    // Data superior a hoje
//    if ([dt earlierDate:[NSDate date]] != dt)
//        return NO;
//    
//    // Data inferior a 1900
//    NSDate *dt1900 = [df dateFromString:@"01/01/1900"];
//    if ([dt earlierDate:dt1900] == dt)
//        return NO;
//    
//    return YES;
//}

//-(BOOL)validateUrl:(NSString *)url {
//    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
//    return [urlTest evaluateWithObject:url];
//}

//- (BOOL)validatePhone:(NSString *)phone {
//    
//    if (!phone)
//        return NO;
//    
//    BOOL isValid = NO;
//    NSError *error = nil;
//    
//    NSDataDetector *matchdetector = [NSDataDetector dataDetectorWithTypes:(uint64_t)NSTextCheckingTypePhoneNumber
//                                                                    error:&error];
//    NSUInteger matchNumber = [matchdetector numberOfMatchesInString:phone
//                                                            options:0
//                                                              range:NSMakeRange(0, [phone length])];
//    if (matchNumber > 0)
//        isValid = YES;
//    
//    return isValid;
//}

@end
