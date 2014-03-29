//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

// Ordem: #1 (cicle de vida)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

// O init não é um construtor. É um inicializador mesmo.
- (id)init {
    // Em ViewControllers, aqui a arvore de views nao esta construida
    // E os Outlets nao estao ligados ainda
    
    // Somente pode atribuir algo ao self se a mensagem começa com init
    self = [super init];
    
    // Esse if é desnecessário mas é convenção
    if (self) {
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criarContato)];
        
        self.navigationItem.rightBarButtonItem = btn;
        
        
    }
    
    return self;
}

// Ordem: #2
- (void)viewDidLoad
{
    // Aqui a arvore de views ja foi iniciada e os Outlets ligados
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)proximoCampo:(UITextField *)campoAtual {
    
    NSInteger proximaTag = campoAtual.tag + 1;
    
    UIResponder * proximoCampo = [self.view viewWithTag:proximaTag];
    
    // nil é o mesmo valor que 0 (false)
    if (proximoCampo) {
        [proximoCampo becomeFirstResponder];
    } else {
        [campoAtual resignFirstResponder];
    }
    
    
}

- (Contato *)pegaDadosDoFormulario {
    
    Contato * contato = [[Contato alloc]init];
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    self.nome.text = @"";
    self.telefone.text = @"";
    self.email.text = @"";
    self.endereco.text = @"";
    self.site.text = @"";
    
    return contato;
}

- (void)criarContato {
    Contato * contato = [self pegaDadosDoFormulario];
    
    [self.contatos addObject:contato];
    
    NSLog(@"Contato adicionado: %@", self.contatos);
    
    // Herdado do ViewController. Parametro bool YES = force (mesmo que o usuario esteja digitando.
    [self.view endEditing:YES];
    //    [self.site resignFirstResponder];
    // contato[@"nome"]
    
    // Esse é só para quando nao tiver navigation view controller
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
