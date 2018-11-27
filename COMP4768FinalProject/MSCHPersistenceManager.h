//
//  MSCHPersistenceManager.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-26.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSCHPersistenceManager : NSObject
-(void) saveAllCourses:(NSArray *)allCourses;
-(NSArray *) getAllCourses;
-(void) saveSelectedCourses:(NSArray *)selectedCouses;
-(NSArray *) getSelectedCourses;
-(void) saveAddedEvent:(NSArray *)addedEvent;
-(NSArray *) getAddedEvent;
@end

NS_ASSUME_NONNULL_END
