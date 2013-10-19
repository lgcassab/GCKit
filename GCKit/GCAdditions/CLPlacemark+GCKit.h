//
//  CLPlacemark+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 25/08/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.

#import <CoreLocation/CoreLocation.h>

@interface CLPlacemark (GCKit) {
    
}

-(NSString *)nome;
-(NSString *)rua;
-(NSString *)numero;
-(NSString *)cidade;
-(NSString *)bairro;
-(NSString *)estado;
-(NSString *)cep;
-(NSString *)paisSigla;
-(NSString *)paisDescricao;
-(NSString *)oceano;
-(NSString *)enderecoSimples;

@end
