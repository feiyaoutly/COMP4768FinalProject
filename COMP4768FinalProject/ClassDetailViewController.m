//
//  ClassDetailViewController.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-29.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ClassDetailViewController.h"

@interface ClassDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
@property (weak, nonatomic) IBOutlet UILabel *courseSection;

@property (weak, nonatomic) IBOutlet UILabel *courseInstructor;
@property (weak, nonatomic) IBOutlet UITextView *courseLectures;
@property (weak, nonatomic) IBOutlet UITextView *courseEvents;
@property (strong,nonatomic) MSCHNetworkManager *nm;
@property (strong,nonatomic) MSCHPersistenceManager *pm;
@property (strong,nonatomic) NSDictionary *courseInfo;
@property (strong,nonatomic) NSArray *events;



@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nm =[[MSCHNetworkManager alloc]init];
    self.pm = [[MSCHPersistenceManager alloc]init];
    self.courseInfo = [self.pm getCourseInfoOfSubject:self.subject Number:self.number Section:self.section];
    NSLog(@"%@%@",@"insturctor name:",[self.courseInfo valueForKey:@"instructor"]);
    self.courseTitle.text = [NSString stringWithFormat:@"%@%@ %@",@"Course:",[self.courseInfo valueForKey:@"subject"],[self.courseInfo valueForKey:@"number"]];
    self.courseSection.text = [NSString stringWithFormat:@"%@%@",@"Section:",[self.courseInfo valueForKey:@"section"]];
    self.courseInstructor.text = [NSString stringWithFormat:@"%@%@",@"Instructor:",[self.courseInfo valueForKey:@"instructor"]];
    NSArray *lectures = [self.courseInfo valueForKey:@"lectures"];
    self.courseLectures.text = @"Lecture Time:\r\n";
    for(int i=0;i<[lectures count];i++){
        NSDictionary *lecture = [lectures objectAtIndex:i];
        self.courseLectures.text = [self.courseLectures.text stringByAppendingString:[NSString stringWithFormat:@"%@ %@ %@%@",[lecture valueForKey:@"lectureDay"],[lecture valueForKey:@"lectureTime"],[lecture valueForKey:@"lectureLocation"],@"\r\n"]];
    }
    self.courseEvents.text=@"Events for this course:\r\n";
    
    
    NSArray *events = [self.pm getAddedEvent];
    int eventForShow = 0;
    for(int i=0;i<[events count];i++){
        NSDictionary *event = [events objectAtIndex:i];
        if([[event valueForKey:@"subject"] isEqualToString:self.subject] && [[event valueForKey:@"number"] isEqualToString:self.number] && [[event valueForKey:@"section"] isEqualToString:self.section]){
            eventForShow++;
            self.courseEvents.text = [self.courseEvents.text stringByAppendingString:[NSString stringWithFormat:@"%i%@%@ %@%@%@",eventForShow,@". ",[event valueForKey:@"title"],@"DUE:",[event valueForKey:@"date"],@"\r\n"]];
        }
        
    }
    // Do any additional setup after loading the view.
}
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
