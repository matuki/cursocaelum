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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapa addAnnotations:self.contatos];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mapa removeAnnotations:self.contatos];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    MKUserTrackingBarButtonItem * btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    
    self.navigationItem.leftBarButtonItem = btn;
    
    self.mapa.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Este metodo é para customizar o que aparece no callout do pin, mostrando a foto do contato
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString * pool = @"poolName";
    
    //Tem um bug documentado nesta API. Na Documentação, diz que devemos retornar nil quando o annotation enviado for a location do usuario.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView * pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pool];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pool];
    } else {
        pin.annotation = annotation;
    }
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.canShowCallout = YES;
    
    Contato* contato = (Contato *) annotation;
    
    if (contato.foto) {
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        iv.image = contato.foto;
        pin.leftCalloutAccessoryView = iv;
    }
    
    
    return pin;
}
@end
