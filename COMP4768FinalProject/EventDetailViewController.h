//
//  EventDetailViewController.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-28.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DeleteEventDelegate <NSObject>
-(void)removeEvent:(NSInteger)row;
@end

@interface EventDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property(weak,nonatomic) NSDictionary *event;
@property (nonatomic) NSInteger row;
@property id<DeleteEventDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
