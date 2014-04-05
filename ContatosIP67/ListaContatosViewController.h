//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import "FormularioContatoViewControllerDelegate.h"

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate>

@property (weak) NSMutableArray * contatos;

// Para tipo primitivo, é sempre assign.
@property (assign, atomic) NSInteger linhaSelecionada;

- (void) contatoAdicionado: (Contato *) contato;

- (void) contatoAlterado:(Contato *)contato;

@end
