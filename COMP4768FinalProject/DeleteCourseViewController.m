//
//  DeleteCourseViewController.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "DeleteCourseViewController.h"

@interface DeleteCourseViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong,nonatomic) MSCHPersistenceManager *pm;
@property (strong,nonatomic) NSMutableArray *selectedCourses;
@end

@implementation DeleteCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",@"delete course controller loaded");
    self.pm = [[MSCHPersistenceManager alloc]init];
    self.selectedCourses = [NSMutableArray arrayWithArray:[self.pm getSelectedCourses]];
    
    self.coursePicker.dataSource=self;
    self.coursePicker.delegate=self;
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.selectedCourses count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *course = [self.selectedCourses objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%@ %@ %@",[course valueForKey:@"subject"],[course valueForKey:@"number"],[course valueForKey:@"section"]];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)deleteButtonTapped:(id)sender {
    NSDictionary *courseToDelete = [self.selectedCourses objectAtIndex:[self.coursePicker selectedRowInComponent:0]];
    [self.pm removeOneSelectedCourseBySubject:[courseToDelete valueForKey:@"subject"] number:[courseToDelete valueForKey:@"number"] section:[courseToDelete valueForKey:@"section"]];
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
