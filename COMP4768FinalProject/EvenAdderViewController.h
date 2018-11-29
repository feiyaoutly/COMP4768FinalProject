//
//  EvenAdderViewController.h
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AddEventViewControllerDelegate <NSObject>
-(void)notifyPresentingViewControllerDone:(BOOL)finished;
@end
@interface EvenAdderViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextView *noteInput;
@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong,nonatomic) NSMutableArray *selectedCourses;

@property id<AddEventViewControllerDelegate> delegate;
- (IBAction)addPress:(id)sender;

@end

NS_ASSUME_NONNULL_END
