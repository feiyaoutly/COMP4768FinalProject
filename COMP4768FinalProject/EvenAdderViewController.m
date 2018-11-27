//
//  EvenAdderViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "EvenAdderViewController.h"

@interface EvenAdderViewController ()

@end

@implementation EvenAdderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPress:(id)sender {
    
    
        NSDate *date = self.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringFromDate = [formatter stringFromDate:date];
        NSLog(@"%@", stringFromDate);
        
        
    }

@end
