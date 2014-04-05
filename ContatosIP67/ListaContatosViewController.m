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
        self.linhaSelecionada = -1;
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
    // Não atuar para recuperar estado de UI aqui porque ela pode ainda não ter sido carregada/construída.
    // Aqui, por exemplo, a tabela pode ainda nao ter sido carregada.
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Aqui é o lugar para recuperar estado da UI ou qualquer atuação
    
    if (self.linhaSelecionada > -1) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];
        
        // UITableViewScrollPositionNone rola somente o suficiente para a linha afetada aparecer
        [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
        
        // Isso é só um workaround para um bug. Tem que executar outra mensagem que utilize o UITableViewScrollPositionNone para que efetivamente role para a posição
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
        
        self.linhaSelecionada = -1;
    }
}

- (void)viewDidLoad
{
    // Aqui a arvore de views ja foi iniciada e os Outlets ligados
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UILongPressGestureRecognizer * lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:lp];
}

- (void)exibeForm
{
    FormularioContatoViewController * form = [[FormularioContatoViewController alloc]init];
    
    form.delegate = self;
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
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
}

- (void) contatoAdicionado: (Contato *) contato
{
    [self.contatos addObject:contato];
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
}

- (void) contatoAlterado:(Contato *)contato
{
    NSLog(@"O contato %@ foi alterado.", contato);
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
}

// Esse tipo de callback é chamado várias vezes (inicio, meio e fim)
- (void) exibeMaisAcoes:(UIGestureRecognizer *) gesture {
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath * ip = [self.tableView indexPathForRowAtPoint:ponto];
        contatoSelecionado = self.contatos[ip.row];
        
        
        UIActionSheet * as = [[UIActionSheet alloc] initWithTitle:contatoSelecionado.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar email", @"Mostrar mapa", @"Abrir site", nil];
        
        [as showInView:self.view];
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self mostrarMapa];
            break;
        case 3:
            [self abreSite];
            break;
        default:
            break;
    }
}

- (void) ligar
{
    NSLog(@"ligar");
    
    UIDevice * device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPhone"]) {
        // para abrir o dialer preenchido sem ligar, use @"telprompt:"
        NSString * strUrl = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        [self abrirAplicativoEmUrl:strUrl];
    } else {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"Pobre!" message:@"Compre um iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }
}

- (void) enviarEmail
{
    NSLog(@"enviar email");
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * mail = [[MFMailComposeViewController alloc]init];
        
        mail.mailComposeDelegate = self;
        
        [mail setToRecipients:@[contatoSelecionado.email]];
        [mail setSubject:@"Contatos (assunto)"];
        
        [self presentViewController:mail animated:YES completion:nil];
    } else {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"Sem Conta Email" message:@"Não existe conta de email configurada" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }
    
}

- (void) mostrarMapa
{
    NSLog(@"mostrar mapa");
    NSString * strUrl = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoEmUrl:strUrl];
}

- (void) abreSite
{
    NSLog(@"abre site");
    [self abrirAplicativoEmUrl:contatoSelecionado.site];
}

- (void) abrirAplicativoEmUrl:(NSString *) url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // Aqui, como foi chamado o presentViewControllerAnimated, não precisa especificar qual é o controller a ser dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
