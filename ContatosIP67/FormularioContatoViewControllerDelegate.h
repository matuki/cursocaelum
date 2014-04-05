//
//  FormularioContatoViewControllerDelegate.h
//  ContatosIP67
//
//  Created by ios4341 on 05/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>

// Esse <NSObject> é
@protocol FormularioContatoViewControllerDelegate <NSObject>

-(void) contatoAdicionado: (Contato *) contato;


@optional // Tudo para baixo de optional é opcional. Para voltar a ser obrigatório, tem que colocar @required
-(void) contatoAlterado: (Contato *) contato;

@end
