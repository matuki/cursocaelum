//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "AppDelegate.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Cria um contato default da caelum - ilustra uso do SharedPreferences
    [self criarContatoCaelum];
    
    // Lendo contatos gravados
    
    // Linhas abaixo comentadas pela implementação do Core Data
    // CUIDADO: Aqui é sempre o NSDocumentDirectory, nao o NSDocumentation(...)
//    NSArray* docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
//    NSString* docDir = docDirs[0]; // No MacOS, podem haver varios usuarios e portanto varios resultados aqui. Mas no iOS é sempre um só.
//    
//    self.nomeArquivo = [NSString stringWithFormat:@"%@/Contatos", docDir];
//    // Nao precisa de extensao (nao é DOS), mas se quiser, vc pode por .bin, .raw (por convenção)
    
//    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.nomeArquivo];
    
    self.contatos = [self buscarContatos];
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
    lista.context = self.managedObjectContext;
    
    // Esse init recebe um view controller para que seja um root do navigation controller.
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lista];
    // O título é confiugrado dentro da lista pois ela é quem "define" que título o nav tem que mostrar.
    
    self.window.backgroundColor = [UIColor blueColor];
    [self.window makeKeyAndVisible];
    
    // Para usar isso, tem que incluir o MapKit.framework clicando no nome do projeto.
    ContatosNoMapaViewController * mapa = [[ContatosNoMapaViewController alloc] init];
    mapa.contatos = self.contatos;
    UINavigationController * navMapa = [[UINavigationController alloc] initWithRootViewController:mapa];
    
    UITabBarController * tabs = [[UITabBarController alloc] init];
    tabs.viewControllers = @[nav, navMapa];
    
    self.window.rootViewController = tabs;
    
    return YES;
}

- (void) criarContatoCaelum
{
    // NSUserDefaults = SharedPreferences
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    // Este é o padrao de nome de key
    BOOL jaExecutou = [ud boolForKey:@"br.com.caelum.ContatosIP67.config.ja_executou"];
    
    if (!jaExecutou) {
        Contato* contatoCaelum = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
        contatoCaelum.nome = @"Caelum Unidade São Paulo";
        contatoCaelum.telefone = @"11 5571-2571";
        contatoCaelum.email = @"contato@caelum.com.br";
        contatoCaelum.endereco = @"Rua Vergueiro, 3185, Vila Mariana, São Paulo, SP";
        contatoCaelum.site = @"http://www.caelum.com.br";
        contatoCaelum.latitude = @(-23.5883034);
        contatoCaelum.longitude = @(-46.632369);
        
        [self saveContext];
        [ud setBool:YES forKey:@"br.com.caelum.ContatosIP67.config.ja_executou"];
        [ud synchronize];
    }
}

- (NSMutableArray*) buscarContatos
{
    // Carregar objetos do banco no contexto. Passa o nome da entidade (Contato)
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    
    NSSortDescriptor* sd = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    // A ordem de aplicacao da ordenacao é a ordem do descriptor no array passado abaixo.
    [fr setSortDescriptors:@[sd]];
    
    // WHERE do select é o setPredicate
    // NSSortDescriptior serve para listas normais
    NSArray* contatosI = [self.managedObjectContext executeFetchRequest:fr error:nil];
    
    return [contatosI mutableCopy];
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
//    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.nomeArquivo];
    
    // Modificação: Agora é um banco de dados
    [self saveContext];
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

// Codigo do Core Data copiado e colado de outro projeto

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Contatos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ContatosIP67.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
