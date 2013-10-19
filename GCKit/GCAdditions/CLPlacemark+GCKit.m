//
//  CLPlacemark+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 25/08/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "CLPlacemark+GCKit.h"

@implementation CLPlacemark (GCKit)

-(NSString *)nome {
    NSString *retorno = self.name;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)rua {
    NSString *retorno = self.thoroughfare;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)numero {
    NSString *retorno = self.subThoroughfare;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)cidade {
    NSString *retorno = self.locality;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)bairro {
    NSString *retorno = self.subLocality;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)estado {
    NSString *retorno = self.administrativeArea;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)cep {
    NSString *retorno = self.postalCode;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)paisSigla {
    NSString *retorno = self.ISOcountryCode;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)paisDescricao {
    NSString *retorno = self.country;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}
-(NSString *)oceano {
    NSString *retorno = self.ocean;
    if ( (!retorno) || (retorno == NULL) || ([retorno isEqualToString:@"(null)"]) ) {
        retorno = @"";
    }
    return retorno;
}

-(NSString *)enderecoSimples {
    return [NSString stringWithFormat:@"%@, %@, %@", self.rua, self.numero, self.cidade];
}

@end
