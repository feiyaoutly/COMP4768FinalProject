//
//  locationGPS.h
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface locationGPS : NSObject<CLLocationManagerDelegate>
+ (instancetype)sharedlocationGPS;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) double latitude;

@property (nonatomic,strong) void(^locationCompleteBlock)(double longitude,double latitude);
- (void)getAuthorization;
//- (void)alertOpenLocationSwitch;
- (void)startLocation;
@end
