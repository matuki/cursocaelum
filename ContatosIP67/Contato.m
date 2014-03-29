//
//  Contato.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

// Sintetiza nome e direciona para o atributo _nome
// A partir do XCode 4.4 isso é gerado automaticamente
//@synthesize nome = _nome;

//- (void) setNome:(NSString*)nome {
//    _nome = nome;
//}
//
//- (NSString *) nome {
//    return _nome;
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ <%@>", self.nome, self.email];
}

@end
