//
//  EvenAdderViewController.m
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "EvenAdderViewController.h"

@interface EvenAdderViewController (){
    CGRect originalViewFrame;
}

@property (strong,nonatomic) MSCHPersistenceManager *pm;


@end

@implementation EvenAdderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",@"event adder view controller loaded");
    originalViewFrame = self.view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.titleInput.delegate = self;
    self.pm = [[MSCHPersistenceManager alloc]init];
    self.selectedCourses = [NSMutableArray arrayWithArray:[self.pm getSelectedCourses]];
    
    self.coursePicker.dataSource=self;
    self.coursePicker.delegate=self;
    
    
    
    // Do any additional setup after loading the view.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleInput resignFirstResponder];
    [self.noteInput resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
   [self resetView];
    // Get the size of the keyboard.
    CGRect keyboardFrameInWindow = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.view.frame;
    [UIView beginAnimations: @"moveUp" context: nil];
    [UIView setAnimationDuration:0.29];
    float height = [self.view convertRect:keyboardFrameInWindow fromView:nil].size.height;
    self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-height);
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations: @"moveDown" context: nil];
    [UIView setAnimationDuration:0.29];
    [self resetView];
    [UIView commitAnimations];
    return;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPress:(id)sender {
    
    
        NSDate *date = self.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
        NSString *stringFromDate = [formatter stringFromDate:date];
        NSLog(@"%@", stringFromDate);
    
    [self.delegate notifyPresentingViewControllerDone:YES];
        
        
    }

- (void)resetView
{
    self.view.frame = originalViewFrame;
}
@end
