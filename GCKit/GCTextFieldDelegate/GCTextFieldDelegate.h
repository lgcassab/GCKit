//
//  GCTextFieldDelegate.h
//  tecnisa
//
//  Created by Gustavo Cassab on 25/08/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#define GCTextFieldMaskCPF              @"000.000.000-00"
#define GCTextFieldMaskData             @"00/00/0000"
#define GCTextFieldMaskTelefone         @"(00) 0000-0000"
#define GCTextFieldMaskCep              @"00000-000"
#define GCTextFieldMaskMoedaBrasileira  @"R$$$"
#define GCTextFieldMaskMoedaAmericana   @"U$$$"

@interface GCTextFieldDelegate : NSObject <UITextFieldDelegate> {
    
}

+ (GCTextFieldDelegate *)sharedDelegate;

@end
