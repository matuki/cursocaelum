//
//  Contato.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Contato : NSObject <NSCoding, MKAnnotation>

// Chave é só para atributos
// Gerado a partir do @synthesize no .m
//{
//    // Esse _ é só um padrao para nomear atributos internos.
//    NSString * _nome;
//    
//}
// Gerado a partir do @property
//- (void)setNome:(NSString*)nome;
//- (NSString *)nome;

// Na duvida, coloca weak para Outlets e o resto para strong
@property (strong, atomic) NSString *nome;

@property (strong, atomic) NSString *telefone;

@property (strong, atomic) NSString *email;

@property (strong, atomic) NSString *endereco;

@property (strong, atomic) NSNumber *latitude;

@property (strong, atomic) NSNumber *longitude;

@property (strong, atomic) NSString *site;

@property (strong, atomic) UIImage *foto;

@end
