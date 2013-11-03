//
//  GCValidator.h
//  GCKit
//
//  Created by Gustavo Cassab on 03/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCValidator : NSObject {
	
}

+ (BOOL)validateBirthDate:(NSString *)birthDate;
+ (BOOL)validateEmail:(NSString *)emailString;
+ (BOOL)validateCPF:(NSString *)cpf;
+ (BOOL)validateUrl:(NSString *)url;
+ (BOOL)validatePhone:(NSString *)phone;

@end
