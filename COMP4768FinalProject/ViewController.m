//
//  ViewController.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-06.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MSCHNetworkManager *nm= [[MSCHNetworkManager alloc]init];
    [nm getAllSubjects];
    [nm getALLCourseOfSubject:@"MATH"];
}


@end
