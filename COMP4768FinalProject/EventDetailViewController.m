//
//  EventDetailViewController.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *course = [NSString stringWithFormat:@"%@ %@",[self.event valueForKey:@"subject"],[self.event valueForKey:@"number"]];
    NSString *title = [self.event valueForKey:@"title"];
    NSString *date = [self.event valueForKey:@"date"];
    NSString *note = [self.event valueForKey:@"note"];
    
    self.courseLabel.text=course;
    self.eventLabel.text=title;
    self.dueDateLabel.text=date;
    self.noteTextView.text=note;
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)deleteButtonTapped:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
