//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController


- (id) init
{
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        
        
        self.navigationItem.rightBarButtonItem = btn;
        // seletor acima teve respeitar um contrato em que tem nenhum parametro, um parametro (sender) ou dois parametros (sender e ...).
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    // Aqui a arvore de views ja foi iniciada e os Outlets ligados
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)exibeForm
{
    FormularioContatoViewController * form = [[FormularioContatoViewController alloc]init];
    
    form.contatos = self.contatos;

    // Isso mostraria a tela sem o navigation controler
//    [self presentViewController:form animated:YES completion:nil];
    
    [self.navigationController pushViewController:form animated:YES];
}

// O parametro tableView é para o caso de ter mais de uma embaixo desse controller
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contatos count];
}

- (UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // static em C significa uma variável global, mas o compilador só vai enxergar ela no escopo local.
    // esta variável é inicializada quando o app é carregado na memória
    static NSString* pool = @"cellPool";
    
    // Usar o pool otimiza o uso de memoria
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool];
    }
    
    Contato * contato = self.contatos[indexPath.row];
    
    cell.textLabel.text = contato.nome;
    
    return cell;
}


// Callback = o usuario está confirmando uma edição
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Significa que o usuario quer apagar
        // Primeiro se deve apagar o model e depois a view, se nao da pau pois a view consulta o model se for apagada
        [self.contatos removeObjectAtIndex:indexPath.row];
        
        // Açúcar sintatico para criar array @[indexPath]
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Tem outros: Exemplo: ara criar dicionário @{@"chave":obj{@"object}}
        // Tem sugar para criar ns number tambem: @(numberVar)
//        NSNumber * number = @2;
//        int numberInt = 3;
//        NSNumber * number3 = @(numberInt);
    }
    
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Contato * contato = self.contatos[sourceIndexPath.row];
    
    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
    [self.contatos insertObject:contato atIndex:destinationIndexPath.row];
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contato * contato = self.contatos[indexPath.row];
    FormularioContatoViewController * form = [[FormularioContatoViewController alloc] initWithContato:contato];
    
    [self.navigationController pushViewController:form animated:YES];
}

@end
