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

- (void) encodeWithCoder: (NSCoder *)aCoder
{
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.site forKey:@"site"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
    }

    return self;
}

@end
