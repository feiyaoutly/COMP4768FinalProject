//
//  locationManager.h
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject



- (void)geocode:(NSString *)address success:(void(^)(CLPlacemark *pm))success failure:(void(^)())failure;


- (void)reverseGeocodeWithlatitude:(CLLocationDegrees )latitude longitude:(CLLocationDegrees)longitude success:(void(^)(NSString *address))success failure:(void(^)())failure;

-(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;


- (double)countLineDistanceDest:(double)lon1 dest_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;
@end
