//
//  MSCHPersistenceManager.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-26.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "MSCHPersistenceManager.h"

@implementation MSCHPersistenceManager

-(void)initPList{
    
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AllCourses.plist"];
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying allcourses file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AllCourses" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
    url = [docsurl URLByAppendingPathComponent:@"AddedCourses.plist"];
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying addedcourses file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AddedCourses" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
    url = [docsurl URLByAppendingPathComponent:@"AddedEvent.plist"];
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying addedevent file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AddedEvent" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
    
    
}

-(void)saveAllCourses:(NSArray *)allCourses{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AllCourses.plist"];
    if ([allCourses writeToURL:url atomically:YES])
        NSLog(@"allcourse saved to plist");
    else
        NSLog(@"unable to save allcourse to plist");
    
}

-(NSArray *)getAllCourses{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AllCourses.plist"];
    
    NSArray *allCourses = [NSArray arrayWithContentsOfURL:url];
    return allCourses;
}
- (NSArray *)getAllCoursesOfSubject:(NSString *)subject{
    NSMutableArray *courses = [[NSMutableArray alloc]init];
    NSArray *allCourses=[self getAllCourses];
    for(int i=0;i<[allCourses count];i++){
        if([[[allCourses objectAtIndex:i] valueForKey:@"subject"] isEqualToString:subject]){
            [courses addObject:[allCourses objectAtIndex:i]];
        }
    }
    
    return courses;
}

- (NSArray *)getAllCoursesOfSubject:(NSString *)subject Number:(NSString *)number{
    NSMutableArray *courses = [[NSMutableArray alloc]init];
    NSArray *coursesubject = [self getAllCoursesOfSubject:subject];
    for(int i=0;i<[coursesubject count];i++){
        if([[[coursesubject objectAtIndex:i] valueForKey:@"number"] isEqualToString:number]){
            [courses addObject:[coursesubject objectAtIndex:i]];
        }
    }
    return courses;
}
- (NSDictionary *)getCourseInfoOfSubject:(NSString *)subject Number:(NSString *)number Section:(NSString *)section{
    NSArray *from = [self getAllCoursesOfSubject:subject Number:number];
    for(int i=0;i<[from count];i++){
        if([[[from objectAtIndex:i] valueForKey:@"section"] isEqualToString:section]){
            return [from objectAtIndex:i];
        }
    }
    return nil;
}

-(void)saveSelectedCourses:(NSArray *)selectedCouses{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AddedCourses.plist"];
    if ([selectedCouses writeToURL:url atomically:YES])
        NSLog(@"data saved to plist");
    else
        NSLog(@"unable to save data to plist");
    
}

-(NSArray *)getSelectedCourses{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AddedCourses.plist"];
    
    NSArray *addedCourses = [NSArray arrayWithContentsOfURL:url];
    return addedCourses;
}

- (void)saveAddedEvent:(NSArray *)addedEvent{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AddedEvent.plist"];
    if ([addedEvent writeToURL:url atomically:YES])
        NSLog(@"data saved to plist");
    else
        NSLog(@"unable to save data to plist");
}

- (NSArray *)getAddedEvent{
    NSFileManager *fm = [NSFileManager new];
    NSError *err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *url = [docsurl URLByAppendingPathComponent:@"AddedEvent.plist"];
   
    
    NSArray *addedEvent = [NSArray arrayWithContentsOfURL:url];
    return addedEvent;
}

- (BOOL)addEvent:(NSDictionary *)event{
    NSMutableArray *currentEvents = [NSMutableArray arrayWithArray:[self getAddedEvent]];
    
    
    for(int i=0;i<[currentEvents count];i++){
        if([[[currentEvents objectAtIndex:i] valueForKey:@"subject"] isEqualToString:[event valueForKey:@"subject"]] && [[[currentEvents objectAtIndex:i] valueForKey:@"number"] isEqualToString:[event valueForKey:@"number"]] && [[[currentEvents objectAtIndex:i] valueForKey:@"section"] isEqualToString:[event valueForKey:@"section"]] && [[[currentEvents objectAtIndex:i] valueForKey:@"title"] isEqualToString:[event valueForKey:@"title"]])
        {
            return NO;
        }
    }
    [currentEvents addObject:event];
    [self saveAddedEvent:currentEvents];
    return YES;
}

-(BOOL)addOneSelectedCourse:(NSDictionary *)course{
    NSMutableArray *currentCourses = [NSMutableArray arrayWithArray:[self getSelectedCourses]];
    NSLog(@"%@%lu",@"slected course before add:",[currentCourses count]);
    if([currentCourses count]>=1){
        for(int i=0;i<[currentCourses count];i++){
            if([[[currentCourses objectAtIndex:i] valueForKey:@"subject"] isEqualToString:[course valueForKey:@"subject"]] && [[[currentCourses objectAtIndex:i] valueForKey:@"number"] isEqualToString:[course valueForKey:@"number"]] && [[[currentCourses objectAtIndex:i] valueForKey:@"section"] isEqualToString:[course valueForKey:@"section"]])
            {
                return NO;
            }
        }
    }
    
    [currentCourses addObject:course];
    [self saveSelectedCourses:currentCourses];
    NSLog(@"%@%lu",@"slected course after add:",[currentCourses count]);
    return YES;
}

-(BOOL)removeEventByCourseSubject:(NSString *)subject courseNumber:(NSString *)number courseSection:(NSString *)section eventName:(NSString *)name{
    NSMutableArray *currentEvents = [NSMutableArray arrayWithArray:[self getAddedEvent]];
    
    for(int i=0;i<[currentEvents count];i++){
        if([[[currentEvents objectAtIndex:i] valueForKey:@"subject"] isEqualToString:subject] && [[[currentEvents objectAtIndex:i] valueForKey:@"number"] isEqualToString:number] && [[[currentEvents objectAtIndex:i] valueForKey:@"section"] isEqualToString:section] && [[[currentEvents objectAtIndex:i] valueForKey:@"title"] isEqualToString:name]){
            [currentEvents removeObjectAtIndex:i];
            [self saveAddedEvent:currentEvents];
            return YES;
        }
    }
    return NO;
}

-(BOOL)removeOneSelectedCourseBySubject:(NSString *)subject number:(NSString *)number section:(NSString *)section{
    NSMutableArray *currentCourses = [NSMutableArray arrayWithArray:[self getSelectedCourses]];
    NSLog(@"%@%lu",@"slected course before remove:",[currentCourses count]);
    for(int i=0;i<[currentCourses count];i++){
        if([[[currentCourses objectAtIndex:i] valueForKey:@"subject"] isEqualToString:subject] && [[[currentCourses objectAtIndex:i] valueForKey:@"number"] isEqualToString:number] && [[[currentCourses objectAtIndex:i] valueForKey:@"section"] isEqualToString:section]){
            [currentCourses removeObjectAtIndex:i];
            NSLog(@"%@%lu",@"slected course adfter remove:",[currentCourses count]);
            [self saveSelectedCourses:currentCourses];
            return YES;
        }
    }
    return NO;
}


@end
