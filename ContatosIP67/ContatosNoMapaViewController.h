//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios4341 on 12/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Contato.h"

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@property (weak, atomic) NSMutableArray * contatos;

@end
