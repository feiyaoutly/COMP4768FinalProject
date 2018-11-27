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
@property (strong,nonatomic) NSMutableDictionary *courses;

@end

@implementation MSCHNetworkManager
-(void)fetchDataFromServer{
    NSURL *subjectsUrl = [NSURL URLWithString:@"https://storage.googleapis.com/muncomp4768finalproject/subjects.txt"];
    NSError* error;
    NSString *subjectsStr = [NSString stringWithContentsOfURL:subjectsUrl encoding:NSASCIIStringEncoding error:&error];
    NSArray *subjectsarr = [subjectsStr componentsSeparatedByString:@","];
    subjectsarr = [subjectsarr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    self.subjects = [NSMutableArray arrayWithArray:subjectsarr];
    self.courses = [[NSMutableDictionary alloc]init];
    
    for(int i=0;i<[subjectsarr count];i++){
        NSURL *coursesUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",@"https://storage.googleapis.com/muncomp4768finalproject/",[self.subjects objectAtIndex:i],@".txt"]];
        NSString *coursesStr = [NSString stringWithContentsOfURL:coursesUrl encoding:NSASCIIStringEncoding error:&error];
        NSArray *coursesarr = [coursesStr componentsSeparatedByString:@"\r\n"];
        coursesarr = [coursesarr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
        [self.courses setValue:[[NSMutableArray alloc]init] forKey:[subjectsarr objectAtIndex:i]];
        for(int j=0;j<[coursesarr count];j++){
            NSString *courseStr = [coursesarr objectAtIndex:j];
            NSArray *courseDescriptionArr = [courseStr componentsSeparatedByString:@","];
            
            NSMutableDictionary *course = [[NSMutableDictionary alloc]init];
            [course setValue:[self.subjects objectAtIndex:i] forKey:@"subject"];
            [course setValue:[courseDescriptionArr objectAtIndex:0] forKey:@"number"];
            [course setValue:[courseDescriptionArr objectAtIndex:1] forKey:@"section"];
            [course setValue:[courseDescriptionArr objectAtIndex:2] forKey:@"campus"];
            [course setValue:[courseDescriptionArr objectAtIndex:3] forKey:@"title"];
            [course setValue:[courseDescriptionArr objectAtIndex:4] forKey:@"instructor"];
            
            NSMutableArray *lectures = [[NSMutableArray alloc]init];
            for(int k=0;k<[[courseDescriptionArr objectAtIndex:5] intValue];k++){
                NSMutableDictionary *lecture = [[NSMutableDictionary alloc]init];
                [lecture setValue:[courseDescriptionArr objectAtIndex:6+k*3] forKey:@"lectureDay"];
                [lecture setValue:[courseDescriptionArr objectAtIndex:7+k*3] forKey:@"lectureTime"];
                [lecture setValue:[courseDescriptionArr objectAtIndex:8+k*3] forKey:@"lectureLocation"];
                [lectures addObject:lecture];
            }
            [course setValue:lectures forKey:@"lectures"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+6] forKey:@"hasLab"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+7] forKey:@"labDay"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+8] forKey:@"labTime"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+9] forKey:@"labLocation"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+10] forKey:@"hasTutorial"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+11] forKey:@"tutorialDay"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+12] forKey:@"tutorialTime"];
            [course setValue:[courseDescriptionArr objectAtIndex:[[courseDescriptionArr objectAtIndex:5] intValue]*3+6] forKey:@"tutorialLocation"];
            
            [[self.courses valueForKey:[subjectsarr objectAtIndex:i]]addObject:course];
            
            
            
            
        }
    }
    
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
-(NSArray *) getAllCourse{
    NSMutableArray *allCourses = [[NSMutableArray alloc] init];
    for(int i=0;i<[self.subjects count];i++){
        [allCourses addObjectsFromArray:[self.courses valueForKey:[self.subjects objectAtIndex:i]]];
    }
    return allCourses;
}

-(NSArray *)getALLCourseOfSubject:(NSString *)subject{
    
    NSArray *courses = [[NSMutableArray alloc]initWithArray:[self.courses valueForKey:subject]];
    return  courses;
}

-(NSArray *)getALLCourseOfSubject:(NSString *)subject number:(NSString *)number{
    
    NSMutableArray *courses = [[NSMutableArray alloc]init];
    NSArray *coursesOfSubject = [self getALLCourseOfSubject:subject];
    for(int i=0;i<[coursesOfSubject count];i++){
        if([[[coursesOfSubject objectAtIndex:i] valueForKey:@"number"] isEqualToString:number]){
            [courses addObject:[coursesOfSubject objectAtIndex:i]];
        }
    }
    return  courses;
}

- (NSDictionary *)getCourseOfSubject:(NSString *)subject number:(NSString *)number section:(NSString *)section{
    NSArray *coursesOfSubjectAndNumber = [self getALLCourseOfSubject:subject number:number];
    for(int i=0;i<[coursesOfSubjectAndNumber count];i++){
        if([[[coursesOfSubjectAndNumber objectAtIndex:i] valueForKey:@"section"] isEqualToString:section]){
            return [coursesOfSubjectAndNumber objectAtIndex:i];
        }
    }
    return nil;
}

@end
