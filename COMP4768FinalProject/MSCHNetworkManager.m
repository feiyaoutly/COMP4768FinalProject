//
//  MSCHNetworkManager.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "MSCHNetworkManager.h"

@implementation MSCHNetworkManager
-(void)fetchDataFromServer{
    NSURL *subjectsUrl = [NSURL URLWithString:@"https://storage.googleapis.com/muncomp4768finalproject/subjects.txt"];
    NSError* error;
    NSString *subjectsStr = [NSString stringWithContentsOfURL:subjectsUrl encoding:NSASCIIStringEncoding error:&error];
    NSArray *subjects = [subjectsStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    subjects = [subjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    NSLog(@"%@%@",@"subjects fteched from server ",subjectsStr);
}

-(NSMutableArray *) getAllSubjects{
    NSLog(@"get called to getAllSubjects");
    NSMutableArray *subjects = [[NSMutableArray alloc]init];
    return  subjects;
}

- (NSMutableArray *)getALLBuildingCode{
    NSLog(@"get called to getAllBuildingCode");
    NSMutableArray *bc = [[NSMutableArray alloc]init];
    return  bc;
}


-(NSMutableArray *)getALLCourseOfSubject:(NSString *)subject{
    NSLog(@"%@%@",@"get called to getAllCoursesOfSubject:",subject);
    NSMutableArray *courses = [[NSMutableArray alloc]init];
    return  courses;
}


@end
