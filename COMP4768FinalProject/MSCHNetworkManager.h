//
//  MSCHNetworkManager.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-25.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSCHNetworkManager : NSObject

-(NSMutableArray *) getAllSubjects;
-(NSMutableArray *) getALLBuildingCode;
-(NSMutableArray *) getALLCourseOfSubject:(NSString *)subject;

@end

NS_ASSUME_NONNULL_END
