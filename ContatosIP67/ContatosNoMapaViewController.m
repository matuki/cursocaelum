//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 12/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController


- (id)init {
    // Em ViewControllers, aqui a arvore de views nao esta construida
    // E os Outlets nao estao ligados ainda
    
    // Somente pode atribuir algo ao self se a mensagem começa com init
    self = [super init];
    
    if (self) {
        // lista-contatos não é um nome absoluto. é um nome de recurso que pode estar apontando para o @2x, etc.
        // Human interface guidelines - Ver detalhes na página da apple.
        UIImage * img = [UIImage imageNamed:@"mapa-contatos"];
        UITabBarItem * tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:img tag:0];
        self.tabBarItem = tabBarItem;
        
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    MKUserTrackingBarButtonItem * btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
