//
//  ViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) MSCHPersistenceManager *pm;
@property (strong,nonatomic) MSCHNetworkManager *nm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nm = [[MSCHNetworkManager alloc]init];
    
    self.pm = [[MSCHPersistenceManager alloc]init];
    
    //testing below 
    

   
    
    [self.pm initPList];
    
    
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
