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

- (id) initWithContato:(Contato *) contato
{
    self = [super init];
    
    if (self) {
        self.contato = contato;
        self.navigationItem.title = @"Edição";
        
        UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(alterarContato)];
        
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
    
    // Se tem uma referencia pro self.contato, é porque é uma alteração e nao uma inclusao
    if (self.contato) {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.site.text = self.contato.site;
        self.endereco.text = self.contato.endereco;
        
    }
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
    
    if (!self.contato) {
        self.contato = [[Contato alloc]init];
    }
    
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    
    self.nome.text = @"";
    self.telefone.text = @"";
    self.email.text = @"";
    self.endereco.text = @"";
    self.site.text = @"";
    
    return self.contato;
}

- (void)criarContato {
    Contato * contato = [self pegaDadosDoFormulario];
    
    [self.delegate contatoAdicionado: contato];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"Contato adicionado: %@", contato);
    
    // Herdado do ViewController. Parametro bool YES = force (mesmo que o usuario esteja digitando.
    [self.view endEditing:YES];
    //    [self.site resignFirstResponder];
    // contato[@"nome"]
    
    // Esse é só para quando nao tiver navigation view controller
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) alterarContato
{
    [self pegaDadosDoFormulario];
    
    if ([self.delegate respondsToSelector:@selector(contatoAlterado:)]) {
        [self.delegate contatoAlterado:self.contato];
    }
    
    // Cuidado com outras mensagens parecidas pop(...) aqui
    [self.navigationController popViewControllerAnimated:YES];
}

@end
