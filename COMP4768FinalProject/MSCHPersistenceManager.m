//
//  MSCHPersistenceManager.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-26.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "MSCHPersistenceManager.h"

@implementation MSCHPersistenceManager

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
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying allcourses file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AllCourses" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
    NSArray *allCourses = [NSArray arrayWithContentsOfURL:url];
    return allCourses;
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
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying addedcourses file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AddedCourses" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
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
    if (![fm fileExistsAtPath:url.path])
    {
        // copy file to from app bundle
        NSLog(@"Copying addedevent file to Documents");
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"AddedEvent" ofType:@"plist"];
        [fm copyItemAtPath:resourcePath toPath:url.path error:&err];
        // check error
    }
    NSArray *addedEvent = [NSArray arrayWithContentsOfURL:url];
    return addedEvent;
}

@end
