//
//  ViewController.m
//  WebServices
//
//  Created by ios4341 on 26/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadLoans];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) loadLoans
{
    // Aqui passamos o serializer JSON do AFNetworking porque se fosse POST e tivesse parametro, iria no formato JSON
    NSMutableURLRequest * req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising" parameters:nil error:nil];
    
    AFHTTPRequestOperation * op = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id response) {
        NSDictionary * res = (NSDictionary *) response;
        self.loans = [res objectForKey:@"loans"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError* error){
        NSLog(@"Erro %@", error);
    }];
    
    [op start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.loans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pool = @"pool";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"pool"];
        [self configureCell:cell withLoanInfo:self.loans[indexPath.row]];
    }
    
    return cell;
}

- (void) configureCell:(UITableViewCell *)cell withLoanInfo:(NSDictionary*) info
{
    NSString * name = info[@"name"];
    
    NSDictionary * location = info[@"location"];
    
    NSString * country = location[@"country"];
    
    NSNumber * amount = info[@"loan_amount"];
    
    NSString * use = info[@"use"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ from %@", name, country];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Needs %@ USD %@", amount, use];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
