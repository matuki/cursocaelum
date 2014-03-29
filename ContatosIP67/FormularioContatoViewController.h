//
//  FormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface FormularioContatoViewController : UIViewController

// Default é atomic
@property (weak) NSMutableArray * contatos;

@property (weak, nonatomic) IBOutlet UITextField *nome;

@property (weak, nonatomic) IBOutlet UITextField *telefone;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *endereco;

@property (weak, nonatomic) IBOutlet UITextField *site;

// Arrastado do evento didSendoOnExit (bota direito em cima do text field).
- (IBAction)proximoCampo:(UITextField *)campoAtual;

- (Contato *)pegaDadosDoFormulario;
@end
