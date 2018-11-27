//
//  locationGPS.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "locationGPS.h"

@implementation locationGPS
+(instancetype)sharedlocationGPS
{
    static locationGPS * _sharedGps = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedGps = [[locationGPS alloc] init];
    });
    return _sharedGps;
}



- (void)getAuthorization
{
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                break;
                
            case kCLAuthorizationStatusNotDetermined:
                [self.locationManager requestWhenInUseAuthorization];
                break;
            case kCLAuthorizationStatusDenied:
                [self alertOpenLocationSwitch];
                break;
            default:
                break;
        }
    }
    
}

- (void)alertOpenLocationSwitch
{

    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Title"
                                 message:@"Message"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    //[self presentViewController:alert animated:YES completion:nil];
}


- (void)startLocation
{
    [_locationManager startUpdatingLocation];
}

#pragma mark - LocationManager
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//location accuracy
        _locationManager.distanceFilter = 10;//located every 10 meter
    }
    return _locationManager;
}

#pragma mark -locationManager delegate
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [manager startUpdatingLocation];
//    }
//}

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    //take out the coordinate
    CLLocationCoordinate2D coordinate = location.coordinate;
    _longitude = coordinate.longitude;
    _latitude = coordinate.latitude;
    // print out the coordinate on bundle
    NSLog(@"didUpdateLocations------%f %f", coordinate.latitude, coordinate.longitude);
    if (self.locationCompleteBlock) {
        self.locationCompleteBlock(_longitude,_latitude);
    }
    [_locationManager stopUpdatingLocation];//stop locating
}

@end

