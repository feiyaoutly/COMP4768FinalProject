//
//  MapViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "locationGPS.h"
#import "Myanotation.h"
#import "locationManager.h"

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
- (IBAction)backClick:(id)sender;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationGPS *loc = [locationGPS sharedlocationGPS];
    [loc getAuthorization];
    [loc startLocation];
    
    //keep track the location of user
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    
    self.mapView.delegate = self;
    
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    userLocation.title = [NSString stringWithFormat:@"longitude：%f",center.longitude];
    userLocation.subtitle = [NSString stringWithFormat:@"latitude：%f",center.latitude];
    
    NSLog(@"location：%f %f --- %i",center.latitude,center.longitude,mapView.showsUserLocation);
    
    if (mapView.showsUserLocation) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
          
            NSLog(@"working");
            [mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        });
    }
    
    
   
    
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if (![annotation isKindOfClass:[Myanotation class]]) {
        return nil;
    }
    
    static NSString *ID = @"anno";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    Myanotation *anno = annotation;
    annoView.image = [UIImage imageNamed:@"map_locate_blue"];
    annoView.annotation = anno;
    
    return annoView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView--%@",view);
}

- (IBAction)backClick:(UIButton *)sender {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:tap.view];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    NSLog(@"%@",self.mapView.annotations);
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = self.mapView.annotations.count;
    if (count > 1) {
        for (id obj in self.mapView.annotations) {
            if (![obj isKindOfClass:[MKUserLocation class]]) {
                [array addObject:obj];
            }
        }
        [self.mapView removeAnnotations:array];
    }
    MKUserLocation *locationAnno = self.mapView.annotations[0];
    
    Myanotation *anno = [[Myanotation alloc] init];
    
    anno.coordinate = coordinate;
    anno.title = [NSString stringWithFormat:@"longtitude：%f",coordinate.longitude];
    anno.subtitle = [NSString stringWithFormat:@"latitude：%f",coordinate.latitude];
    
    self.longitudeLabel.text = [NSString stringWithFormat:@"longitude：%f",coordinate.longitude];
    self.latitudeLabel.text = [NSString stringWithFormat:@"latitude：%f",coordinate.latitude];
    //translate coordinate back to address
    LocationManager *locManager = [[LocationManager alloc] init];
    [locManager reverseGeocodeWithlatitude:coordinate.latitude longitude:coordinate.longitude success:^(NSString *address) {
       self.addressLabel.text = [NSString stringWithFormat:@"%@",address];
    } failure:^{
        
    }];
    
    //distance
    double distance = [locManager countLineDistanceDest:coordinate.longitude dest_Lat:coordinate.latitude self_Lon:locationAnno.coordinate.longitude self_Lat:locationAnno.coordinate.latitude];
    self.distanceLabel.text = [NSString stringWithFormat:@"%d meter away",(int)distance];
    
    [self.mapView addAnnotation:anno];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}


@end
