//
//  FormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosViewController.h"
#import "FormularioContatoViewControllerDelegate.h"

@interface FormularioContatoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// Default é atomic
//@property (weak) NSMutableArray * contatos;

// Usado na edição
@property (strong, atomic) Contato * contato;

@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;

@property (weak, atomic) id<FormularioContatoViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nome;

@property (weak, nonatomic) IBOutlet UITextField *telefone;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *endereco;

@property (strong, nonatomic) IBOutlet UITextField *latitude;

@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (weak, nonatomic) IBOutlet UITextField *site;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *rodinha;

// Arrastado do evento didSendoOnExit (bota direito em cima do text field).
// Removido pois tem essa feature no pod TPKeyboardAvoiding que estamos usando
//- (IBAction)proximoCampo:(UITextField *)campoAtual;

- (Contato *)pegaDadosDoFormulario;

- (id) initWithContato:(Contato *) contato;

- (IBAction)selecionaFoto:(id)sender;


@end
