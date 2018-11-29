//
//  EventTableViewCell.m
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateCellWithCourseTitle:(NSString *)courseTitle eventTitle:(NSString *)eventTitle eventDate:(NSString *)eventDate eventTime:(NSString *)eventTime{
    self.courseTitle.text=courseTitle;
    self.eventTitle.text=eventTitle;
    self.eventDate.text=eventDate;
    self.eventTime.text=eventTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
