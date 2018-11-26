//
//  MSCHNetworkManager.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "MSCHNetworkManager.h"
@interface MSCHNetworkManager()
@property (strong,nonatomic) NSMutableArray *subjects;

@end

@implementation MSCHNetworkManager
-(void)fetchDataFromServer{
    NSURL *subjectsUrl = [NSURL URLWithString:@"https://storage.googleapis.com/muncomp4768finalproject/subjects.txt"];
    NSError* error;
    NSString *subjectsStr = [NSString stringWithContentsOfURL:subjectsUrl encoding:NSASCIIStringEncoding error:&error];
    NSArray *subjectsarr = [subjectsStr componentsSeparatedByString:@","];
    subjectsarr = [subjectsarr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    self.subjects = [NSMutableArray arrayWithArray:subjectsarr];
    NSLog(@"%@%@",@"subjects fteched from server ",subjectsStr);
    NSLog(@"%@%@%@%@",@"subjects are:",[subjectsarr objectAtIndex:0],[subjectsarr objectAtIndex:1],[subjectsarr objectAtIndex:2]);
    NSLog(@"%@%@%@%@",@"subjects are:",[self.subjects objectAtIndex:0],[self.subjects objectAtIndex:1],[self.subjects objectAtIndex:2]);
}

-(NSArray *) getAllSubjects{
    NSLog(@"get called to getAllSubjects");
    
    return [NSArray arrayWithArray:self.subjects];
}

- (NSArray *)getALLBuildingCode{
    NSLog(@"get called to getAllBuildingCode");
    NSArray *bc = [[NSArray alloc]init];
    return  bc;
}


-(NSArray *)getALLCourseOfSubject:(NSString *)subject{
    NSLog(@"%@%@",@"get called to getAllCoursesOfSubject:",subject);
    NSArray *courses = [[NSMutableArray alloc]init];
    return  courses;
}


@end
