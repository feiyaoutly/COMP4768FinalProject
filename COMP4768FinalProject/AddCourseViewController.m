//
//  AddCourseViewController.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "AddCourseViewController.h"

@interface AddCourseViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *subjectPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *numberPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sectionPicker;
@property (strong,nonatomic) MSCHNetworkManager *nm;

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",@"add course view controller loaded");
   self.nm = [[MSCHNetworkManager alloc]init];
    [self.nm fetchDataFromServer];
    NSLog(@"%@%@%@",[[self.nm getAllSubjects]objectAtIndex:0],[[self.nm getAllSubjects]objectAtIndex:1],[[self.nm getAllSubjects]objectAtIndex:2] );
    self.subjectPicker.dataSource=self;
    self.subjectPicker.delegate=self;
    self.numberPicker.dataSource=self;
    self.numberPicker.delegate=self;
    self.sectionPicker.dataSource=self;
    self.sectionPicker.delegate=self;
    
}
- (IBAction)subjectConfirmed:(id)sender {
}
- (IBAction)numberConfirmed:(id)sender {
}

- (IBAction)sectionConfirmed:(id)sender {
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *subjects = [self.nm getAllSubjects];
    if(pickerView.tag==9501){
        return [subjects count];
    }
    else if(pickerView.tag==9502){
        
        NSArray *coursesNumbers = [self.nm getAllCourseNumberOfSubject:[subjects objectAtIndex:[self.subjectPicker selectedRowInComponent:0]]];
        return [coursesNumbers count];
    }
    else if(pickerView.tag==9503){
        NSString *subject =[subjects objectAtIndex:[self.subjectPicker selectedRowInComponent:0]];
        NSArray *coursesNumbers = [self.nm getAllCourseNumberOfSubject:subject];
        NSString *number = [coursesNumbers objectAtIndex:[self.numberPicker selectedRowInComponent:0]];
        NSArray *sections = [self.nm getAllSectionNumberOfSubject:subject number:number];
        
        return [sections count];
        
    }
    return nil;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *subjects = [self.nm getAllSubjects];
    if(pickerView.tag==9501){
        return [subjects objectAtIndex:row];
    }
    else if(pickerView.tag==9502){
        
        NSArray *coursesNumbers = [self.nm getAllCourseNumberOfSubject:[subjects objectAtIndex:[self.subjectPicker selectedRowInComponent:0]]];
        return [coursesNumbers objectAtIndex:row];
    }
    else if(pickerView.tag==9503){
        NSString *subject =[subjects objectAtIndex:[self.subjectPicker selectedRowInComponent:0]];
        NSArray *coursesNumbers = [self.nm getAllCourseNumberOfSubject:subject];
        NSString *number = [coursesNumbers objectAtIndex:[self.numberPicker selectedRowInComponent:0]];
        NSArray *sections = [self.nm getAllSectionNumberOfSubject:subject number:number];
        NSString *section = [sections objectAtIndex:row];
        
        return section;
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag==9501){
        [self.numberPicker reloadAllComponents];
        [self.sectionPicker reloadAllComponents];
    }
    else if(pickerView.tag==9502){
        [self.sectionPicker reloadAllComponents];
       
        
    }
    
    
}
- (IBAction)addButtonTapped:(id)sender {
  
}
- (IBAction)cancelButtonTapped:(id)sender {
    
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
