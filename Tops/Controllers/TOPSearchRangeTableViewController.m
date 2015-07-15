//
//  TOPSearchRangeTableViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/7/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPSearchRangeTableViewController.h"
#import "TOPHomeViewController.h"

@interface TOPSearchRangeTableViewController ()

@end

@implementation TOPSearchRangeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *myBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    [self.view addSubview:myBar];
    
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Выбор радиуса"];
    myBar.items = [NSArray arrayWithObject:item];

    //item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //rangeCell = [[[NSBundle mainBundle] loadNibNamed:@"TOPSearchRangeTableViewCell" owner:self options:nil] objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [UITableViewCell new];
    
    if(indexPath.row == 1){
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TOPSearchRange1TableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
    }
    if(indexPath.row == 2){
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TOPSearchRange3TableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
    }
    if(indexPath.row == 3){
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TOPSearchRange5TableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 60;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *allFilters = [[NSMutableDictionary alloc] init];
    NSString *rangeFilter;
    
    if(indexPath.row == 1){
        rangeFilter = [NSString stringWithFormat:@"1 км"];
    }
    else if(indexPath.row == 2){
        rangeFilter = [NSString stringWithFormat:@"3 км"];
    }
    else if(indexPath.row == 3){
        rangeFilter = [NSString stringWithFormat:@"5 км"];
    }
    
    [allFilters setValue:rangeFilter forKey:@"rangeFilter"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshDataWithFilters" object:self userInfo:allFilters];
    
    [self presentViewController:[TOPHomeViewController new]
                       animated:YES
                     completion:nil];
    NSLog(@"Successfully logged in");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
