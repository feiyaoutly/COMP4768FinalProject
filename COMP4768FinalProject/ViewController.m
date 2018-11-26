//
//  ViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MSCHNetworkManager *nm = [[MSCHNetworkManager alloc]init];
    [nm fetchDataFromServer];
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
