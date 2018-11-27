//
//  EvenAdderViewController.h
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EvenAdderViewController : ViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)addPress:(id)sender;

@end

NS_ASSUME_NONNULL_END
