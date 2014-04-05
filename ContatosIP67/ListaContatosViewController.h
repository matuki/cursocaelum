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


// Quando se faz isso todas as classes do framework são importadas
#import <MessageUI/MessageUI.h>

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

// Atributo da classe
{
    Contato * contatoSelecionado;
}


@property (weak) NSMutableArray * contatos;

// Para tipo primitivo, é sempre assign.
@property (assign, atomic) NSInteger linhaSelecionada;

- (void) contatoAdicionado: (Contato *) contato;

- (void) contatoAlterado:(Contato *)contato;

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;


@end
