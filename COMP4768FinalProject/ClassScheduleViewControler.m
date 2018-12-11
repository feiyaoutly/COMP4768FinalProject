//
//  ClassScheduleViewControler.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ClassScheduleViewControler.h"

@interface ClassScheduleViewControler ()

@property (strong,nonatomic) NSMutableArray *allCourses;
@property (strong,nonatomic) NSMutableArray *selectedCourses;
@property (strong,nonatomic) MSCHNetworkManager *nm;
@property (strong,nonatomic) MSCHPersistenceManager *pm;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ClassScheduleViewControler
-(void)showAlert{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        NSArray * courses = [self.pm getAllCourses];
        if([courses count]==0){
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Fetch Data"
                                         message:@"Please connect to WIFI to donwload database"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* dismiss = [UIAlertAction
                                      actionWithTitle:@"Dismiss"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          
                                      }];
            [alert addAction:dismiss];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
    }
    else if (status == ReachableViaWiFi)
    {
        [self.nm fetchDataFromServer];
    }
    else if (status == ReachableViaWWAN)
    {
        NSArray * courses = [self.pm getAllCourses];
        if([courses count]==0){
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Fetch Data"
                                         message:@"Please connect to WIFI to donwload database"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* dismiss = [UIAlertAction
                                      actionWithTitle:@"Dismiss"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          
                                      }];
            [alert addAction:dismiss];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@%@",@"type of subview", NSStringFromClass([self.scrollView class]));
    // Do any additional setup after loading the view.
    NSLog(@"%@",@"class schedule view controller loaded");
    self.nm = [[MSCHNetworkManager alloc]init];
    self.pm = [[MSCHPersistenceManager alloc]init];
    
    
    
    
    
    
    self.allCourses = [NSMutableArray arrayWithArray:[self.pm getAllCourses]];
    self.selectedCourses = [NSMutableArray arrayWithArray:[self.pm getSelectedCourses]];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*1.6, self.view.frame.size.height*1.1)];
    
    //make button for each course
    for(int i=0;i<[self.selectedCourses count];i++){
        NSDictionary *thisCourse = [self.selectedCourses objectAtIndex:i];
        NSString *thisSubject = [thisCourse valueForKey:@"subject"];
        NSString *thisNumber = [thisCourse valueForKey:@"number"];
        NSString *thisSection = [thisCourse valueForKey:@"section"];
        NSDictionary *courseInfo = [self.pm getCourseInfoOfSubject:thisSubject Number:thisNumber Section:thisSection];
        NSArray *thisLectures = [courseInfo valueForKey:@"lectures"];
        
        for(int j=0;j<[thisLectures count];j++){
            NSArray *lectureInfo = [thisLectures objectAtIndex:j];
            NSString *lectureDay = [lectureInfo valueForKey:@"lectureDay"];
            NSString *lectureTime = [lectureInfo valueForKey:@"lectureTime"];
            NSString *lectureLocation = [lectureInfo valueForKey:@"lectureLocation"];
            UIButton *lecture = [UIButton buttonWithType:UIButtonTypeSystem];
            NSString *buttonTitle = [NSString stringWithFormat:@"%@ %@",thisSubject,thisNumber];
            buttonTitle = [buttonTitle stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\r\n",thisSection]];
            buttonTitle = [buttonTitle stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\r\n",lectureLocation]];
            [lecture setTitle:buttonTitle forState:UIControlStateNormal];
            CGFloat xLocation = 0.0;
            CGFloat yLocation = -280.0;
            
            if([lectureDay isEqualToString:@"M"]){
                xLocation = 150;
            }
            else if([lectureDay isEqualToString:@"T"]){
                xLocation = 250;
            }
            else if([lectureDay isEqualToString:@"W"]){
                xLocation = 350;
            }
            else if([lectureDay isEqualToString:@"R"]){
                xLocation = 450;
            }
            else if([lectureDay isEqualToString:@"F"]){
                xLocation = 550;
            }
            NSArray *timeBound = [lectureTime componentsSeparatedByString:@"-"];
            NSLog(@"%@%@ %@",@"start time and end time are:",[timeBound objectAtIndex:0],[timeBound objectAtIndex: 1]);
            NSString *startTimeStr = [timeBound objectAtIndex:0];
            NSArray *startArray = [startTimeStr componentsSeparatedByString:@" "];
            NSString *ampm = [startArray objectAtIndex:1];
            NSString *startTime = [startArray objectAtIndex:0];
            NSArray *timeArray = [startTime componentsSeparatedByString:@":"];
            NSString *hourStr = [timeArray objectAtIndex:0];
            NSString *minuteStr = [timeArray objectAtIndex:1];
            if([ampm isEqualToString:@"pm"]){
                yLocation=yLocation+480.0;
            }
            
            NSInteger hour = [hourStr integerValue];
            NSInteger min = [minuteStr integerValue];
            
            if(hour!=12){
                yLocation=yLocation+480.0/12*hour;
            }
            yLocation = yLocation+30.0*(min/60.0);
            
            lecture.bounds = CGRectMake(0, 0, 100, 50);
            lecture.center = CGPointMake(xLocation, yLocation);
            [lecture addTarget:self action:@selector(courseClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            lecture.tag = 9000;
            
            [self.scrollView addSubview:lecture];
        }
    }
    
    CGRect labelLocation = CGRectMake(0, 0, 100, 40);
    UILabel *mon = [[UILabel alloc]initWithFrame:labelLocation];
    mon.center=CGPointMake(150, 20);
    [mon setText:@"Monday"];
    mon.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:mon];
    UILabel *tues = [[UILabel alloc]initWithFrame:labelLocation];
    tues.center=CGPointMake(250, 20);
    [tues setText:@"Tuesday"];
    tues.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:tues];
    UILabel *wed = [[UILabel alloc]initWithFrame:labelLocation];
    wed.center=CGPointMake(350, 20);
    [wed setText:@"Wednesday"];
    wed.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:wed];
    UILabel *thur = [[UILabel alloc]initWithFrame:labelLocation];
    thur.center=CGPointMake(450, 20);
    [thur setText:@"Thursday"];
    thur.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:thur];
    UILabel *fri = [[UILabel alloc]initWithFrame:labelLocation];
    fri.center=CGPointMake(550, 20);
    [fri setText:@"Friday"];
    fri.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:fri];
    for(int i=0;i<4;i++){
        UILabel *morning = [[UILabel alloc]initWithFrame:labelLocation];
        morning.center=CGPointMake(50, 40+40*i);
        [morning setText:[NSString stringWithFormat:@"%i%@ %@",i+8,@":00",@"AM"]];
        morning.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:morning];
    }
    UILabel *noon = [[UILabel alloc]initWithFrame:labelLocation];
    noon.center=CGPointMake(50, 200);
    [noon setText:[NSString stringWithFormat:@"%i%@ %@",12,@":00",@"PM"]];
    noon.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:noon];
    for(int i=0;i<10;i++){
        UILabel *afternoon = [[UILabel alloc]initWithFrame:labelLocation];
        afternoon.center=CGPointMake(50, 240+40*i);
        [afternoon setText:[NSString stringWithFormat:@"%i%@ %@",i+1,@":00",@"PM"]];
        afternoon.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:afternoon];
    }
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self showAlert];
    NSLog(@"%@",@"class schedule appear");
    NSArray *coursesAfter = [self.pm getSelectedCourses];
    if([coursesAfter count]!=[self.selectedCourses count]){
        self.selectedCourses=[NSMutableArray arrayWithArray:coursesAfter];
        for(UIView *view in [self.scrollView subviews]){
            if(view.tag==9000){
                [view removeFromSuperview];
            }
            
            
        }
        //make button for each course
        for(int i=0;i<[self.selectedCourses count];i++){
            NSDictionary *thisCourse = [self.selectedCourses objectAtIndex:i];
            NSString *thisSubject = [thisCourse valueForKey:@"subject"];
            NSString *thisNumber = [thisCourse valueForKey:@"number"];
            NSString *thisSection = [thisCourse valueForKey:@"section"];
            NSDictionary *courseInfo = [self.pm getCourseInfoOfSubject:thisSubject Number:thisNumber Section:thisSection];
            NSArray *thisLectures = [courseInfo valueForKey:@"lectures"];
            
            for(int j=0;j<[thisLectures count];j++){
                NSArray *lectureInfo = [thisLectures objectAtIndex:j];
                NSString *lectureDay = [lectureInfo valueForKey:@"lectureDay"];
                NSString *lectureTime = [lectureInfo valueForKey:@"lectureTime"];
                NSString *lectureLocation = [lectureInfo valueForKey:@"lectureLocation"];
                UIButton *lecture = [UIButton buttonWithType:UIButtonTypeSystem];
                NSString *buttonTitle = [NSString stringWithFormat:@"%@ %@",thisSubject,thisNumber];
                buttonTitle = [buttonTitle stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\r\n",thisSection]];
                buttonTitle = [buttonTitle stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\r\n",lectureLocation]];
                [lecture setTitle:buttonTitle forState:UIControlStateNormal];
                CGFloat xLocation = 0.0;
                CGFloat yLocation = -280.0;
                
                if([lectureDay isEqualToString:@"M"]){
                    xLocation = 150;
                }
                else if([lectureDay isEqualToString:@"T"]){
                    xLocation = 250;
                }
                else if([lectureDay isEqualToString:@"W"]){
                    xLocation = 350;
                }
                else if([lectureDay isEqualToString:@"R"]){
                    xLocation = 450;
                }
                else if([lectureDay isEqualToString:@"F"]){
                    xLocation = 550;
                }
                NSArray *timeBound = [lectureTime componentsSeparatedByString:@"-"];
                NSLog(@"%@%@ %@",@"start time and end time are:",[timeBound objectAtIndex:0],[timeBound objectAtIndex: 1]);
                NSString *startTimeStr = [timeBound objectAtIndex:0];
                NSArray *startArray = [startTimeStr componentsSeparatedByString:@" "];
                NSString *ampm = [startArray objectAtIndex:1];
                NSString *startTime = [startArray objectAtIndex:0];
                NSArray *timeArray = [startTime componentsSeparatedByString:@":"];
                NSString *hourStr = [timeArray objectAtIndex:0];
                NSString *minuteStr = [timeArray objectAtIndex:1];
                if([ampm isEqualToString:@"pm"]){
                    yLocation=yLocation+480.0;
                }
                
                NSInteger hour = [hourStr integerValue];
                NSInteger min = [minuteStr integerValue];
                
                if(hour!=12){
                    yLocation=yLocation+480.0/12*hour;
                }
                yLocation = yLocation+30.0*(min/60.0);
                
                lecture.bounds = CGRectMake(0, 0, 100, 50);
                lecture.center = CGPointMake(xLocation, yLocation);
                [lecture addTarget:self action:@selector(courseClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                lecture.tag = 9000;
                
                [self.scrollView addSubview:lecture];
            }
        }
    }
}

-(void)courseClicked:(UIButton *)sender{
    NSLog(@"%@%@",@"clicked course:",sender.titleLabel.text);
    [self performSegueWithIdentifier:@"classDetail" sender:sender];
    //ClassDetailViewController *vc = [[ClassDetailViewController alloc]init];
    //[self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"addCourse"]){
        NSLog(@"%@",@"prepare segue way for add course");
    }
    else if([[segue identifier] isEqualToString:@"classDetail"])
    {
        UIButton *button = (UIButton*)sender;
        NSLog(@"%@%@",@"sender text",button.titleLabel.text);
        ClassDetailViewController *vc = [segue destinationViewController];
        NSArray *titlearr = [button.titleLabel.text componentsSeparatedByString:@"\r\n"];
        NSArray *subanum = [[titlearr objectAtIndex:0] componentsSeparatedByString:@" "];
        NSString *subject = [subanum objectAtIndex:0];
        NSString *number = [subanum objectAtIndex:1];
        NSString *section = [titlearr objectAtIndex:1];
        vc.subject = subject;
        vc.number = number;
        vc.section=section;
        
    }
}


@end
