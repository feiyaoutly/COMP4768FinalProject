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

@property (strong,nonatomic) MSCHPersistenceManager *pm;
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
    self.pm = [[MSCHPersistenceManager alloc]init];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    NSArray *selectedCourse = [self.pm getSelectedCourses];
    for(int i=0;i<[selectedCourse count];i++){
        NSDictionary *course = [selectedCourse objectAtIndex:i];
        NSString *subject = [course valueForKey:@"subject"];
        NSString *number = [course valueForKey:@"number"];
        NSString *section = [course valueForKey:@"section"];
        NSDictionary *courseInfo = [self.pm getCourseInfoOfSubject:subject Number:number Section:section];
        NSString * lectureLoc = [[[courseInfo objectForKey:@"lectures"] objectAtIndex:0]valueForKey:@"lectureLocation"];
        NSString *buildingCode = [[lectureLoc componentsSeparatedByString:@" "] objectAtIndex:0];
        Myanotation* ann = [[Myanotation alloc] init];
        if([buildingCode isEqualToString:@"A"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.571314, -52.732216);
        }
        else if([buildingCode isEqualToString:@"BN"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.575399, -52.734161);
        }
        else if([buildingCode isEqualToString:@"BT"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572549, -52.733179);
        }
        else if([buildingCode isEqualToString:@"C"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.573131, -52.733167);
        }
        else if([buildingCode isEqualToString:@"CL"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.576094, -52.731512);
        }
        else if([buildingCode isEqualToString:@"CS"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572123, -52.732691);
        }
        else if([buildingCode isEqualToString:@"ED"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.571088, -52.735984);
        }
        else if([buildingCode isEqualToString:@"EN"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.575023, -52.735692);
        }
        else if([buildingCode isEqualToString:@"ER"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.574093, -52.734383);
        }
        else if([buildingCode isEqualToString:@"FM"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572720, -52.730632);
        }
        else if([buildingCode isEqualToString:@"H"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572242, -52.741800);
        }
        else if([buildingCode isEqualToString:@"HH"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.571508, -52.731029);
        }
        else if([buildingCode isEqualToString:@"IIC"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.571630, -52.733235);
        }
        else if([buildingCode isEqualToString:@"J"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.575412, -52.732793);
        }
        else if([buildingCode isEqualToString:@"MU"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572148, -52.730468);
        }
        else if([buildingCode isEqualToString:@"PE"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.570722, -52.734176);
        }
        else if([buildingCode isEqualToString:@"QC"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.577414, -52.730592);
        }
        else if([buildingCode isEqualToString:@"SN"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.572449, -52.731939);
        }
        else if([buildingCode isEqualToString:@"UC"]){
            ann.coordinate = CLLocationCoordinate2DMake(47.573230, -52.735187);
        }
        
        ann.title = [NSString stringWithFormat:@"%@ %@",subject,number ];
        ann.subtitle =[NSString stringWithFormat:@"%@ %@",@"Lecture:",lectureLoc ];
        NSLog(@"%@%@",@"loc:",buildingCode);
        
        [self.mapView addAnnotation:ann];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    userLocation.title = @"userLocation";
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
    
    if([annotation.title isEqualToString:@"currentSelection"]){
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
    else if(![annotation.title isEqualToString:@"userLocation"]){
        MKAnnotationView* v = nil;
        static NSString* ident = @"pin";
        v = [mapView dequeueReusableAnnotationViewWithIdentifier:ident];
        if (v == nil)
        {
            v = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ident];
            ((MKPinAnnotationView*)v).pinTintColor = [MKPinAnnotationView greenPinColor];
            v.canShowCallout = YES;
            ((MKPinAnnotationView *)v).animatesDrop = YES;
        } else
        {
            v.annotation = annotation;
        }
        return v;
    }
    
    return nil;
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
                Myanotation *anno = (Myanotation*)obj;
                if([anno.title isEqualToString:@"currentSelection"]){
                    [array addObject:obj];
                }
                
            }
        }
        [self.mapView removeAnnotations:array];
    }
    MKUserLocation *locationAnno = self.mapView.annotations[0];
    
    Myanotation *anno = [[Myanotation alloc] init];
    
    anno.coordinate = coordinate;
    anno.title = @"currentSelection";
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
