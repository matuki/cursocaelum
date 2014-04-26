//
//  Contato.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato
// Fala para o compilador nao gerar getter e setter dessas variaveis
@dynamic nome, telefone, email, endereco, site, latitude, longitude, foto;

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
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.foto forKey:@"foto"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.foto = [aDecoder decodeObjectForKey:@"foto"];
    }

    return self;
}

- (CLLocationCoordinate2D) coordinate
{   CLLocationCoordinate2D result = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    return result;
}

- (NSString *) title {
    return self.nome;
}

- (NSString *) subtitle {
    return self.email;
}



@end
