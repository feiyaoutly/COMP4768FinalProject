//
//  EvenListTableViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "EvenListTableViewController.h"

@interface EvenListTableViewController ()
@property (strong, nonatomic) EvenAdderViewController *addEventVC;
@property (strong,nonatomic) MSCHPersistenceManager *pm;
@property (strong,nonatomic) NSMutableArray *events;
@end

@implementation EvenListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",@"event list view controller loaded");
    self.pm = [[MSCHPersistenceManager alloc]init];
    self.events = [self.pm getAddedEvent];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return 1;
}
-(void)notifyPresentingViewControllerDone:(BOOL)finished{
    
    NSDate *eventDate = self.addEventVC.datePicker.date;
    NSString *eventTitle = self.addEventVC.titleInput.text;
    NSString *eventNote = self.addEventVC.noteInput.text;
    NSDictionary *course = [self.addEventVC.selectedCourses objectAtIndex:[self.addEventVC.coursePicker selectedRowInComponent:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    NSString *dateString = [formatter stringFromDate:eventDate];
    NSMutableDictionary *event = [[NSMutableDictionary alloc]init];
    [event setValue:[course valueForKey:@"subject"] forKey:@"subject"];
    [event setValue:[course valueForKey:@"number"] forKey:@"number"];
    [event setValue:[course valueForKey:@"section"] forKey:@"section"];
    [event setValue:eventTitle forKey:@"title"];
    [event setValue:eventNote forKey:@"note"];
    [event setValue:dateString forKey:@"date"];
    [self.pm addEvent:event];
    [self.events addObject:event];
    [self.tableView reloadData];
    UINavigationController *navCon = (UINavigationController*)self.parentViewController;
    //return to the root tableview controller
    [navCon popToRootViewControllerAnimated:YES];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"addEvent"]){
        self.addEventVC = [segue destinationViewController];
        self.addEventVC.delegate=self;
    }
}


@end
