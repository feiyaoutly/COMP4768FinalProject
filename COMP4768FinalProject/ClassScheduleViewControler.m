//
//  ClassScheduleViewControler.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ClassScheduleViewControler.h"

@interface ClassScheduleViewControler ()

@end

@implementation ClassScheduleViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",@"class schedule view controller loaded");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"addCourse"]){
        NSLog(@"%@",@"prepare segue way for add course");
    }
}


@end
