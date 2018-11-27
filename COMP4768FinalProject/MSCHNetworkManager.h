//
//  MSCHNetworkManager.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCHPersistenceManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface MSCHNetworkManager : NSObject

-(void) fetchDataFromServer;
-(NSArray *) getAllSubjects;
-(NSArray *) getALLBuildingCode;
-(NSArray *) getALLCourseOfSubject:(NSString *)subject;
-(NSArray *) getALLCourseOfSubject:(NSString *)subject number:(NSString *)number;
-(NSDictionary *) getCourseOfSubject:(NSString *)subject number:(NSString *)number section:(NSString *)section;

@end

NS_ASSUME_NONNULL_END
