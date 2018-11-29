//
//  EventTableViewCell.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;
-(void) updateCellWithCourseTitle:(NSString *)courseTitle eventTitle:(NSString *)eventTitle eventDate:(NSString *)eventDate eventTime:(NSString *)eventTime;

@end

NS_ASSUME_NONNULL_END
