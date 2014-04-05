//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "AppDelegate.h"
#import "ListaContatosViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Lendo contatos gravados
    // CUIDADO: Aqui é sempre o NSDocumentDirectory, nao o NSDocumentation(...)
    NSArray* docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* docDir = docDirs[0]; // No MacOS, podem haver varios usuarios e portanto varios resultados aqui. Mas no iOS é sempre um só.
    
    self.nomeArquivo = [NSString stringWithFormat:@"%@/Contatos", docDir];
    // Nao precisa de extensao (nao é DOS), mas se quiser, vc pode por .bin, .raw (por convenção)
    
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.nomeArquivo];
    if (!self.contatos) {
        // Estrutura de dados que será injetada no ListaContatosViewController;
        self.contatos = [[NSMutableArray alloc]init];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // Override point for customization after application launch.
//    FormularioContatoViewController * form = [[FormularioContatoViewController alloc] init];
    
    ListaContatosViewController * lista = [[ListaContatosViewController alloc] init];
    
    // Injeção da dependência da lista
    lista.contatos = self.contatos;
    
    // Esse init recebe um view controller para que seja um root do navigation controller.
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lista];
    // O título é confiugrado dentro da lista pois ela é quem "define" que título o nav tem que mostrar.
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor blueColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// LUGAR BOM PARA PERSISTIR DADOS
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Não é um banco de dados, portanto o arquivo é regravado inteiramente quando cada objeto é inserido. Portanto esta operação é cara e nào deve ser executada toda hora
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.nomeArquivo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


// NEM SEMPRE É CHAMADA.
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
