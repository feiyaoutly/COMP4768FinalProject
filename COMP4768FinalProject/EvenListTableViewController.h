//
//  EvenListTableViewController.h
//  COMP4768FinalProject
//
//  Created by wenrui zhen on 2018-11-27.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableViewCell.h"
#import "EvenAdderViewController.h"
#import "EventDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EvenListTableViewController : UITableViewController<AddEventViewControllerDelegate,DeleteEventDelegate>

@end

NS_ASSUME_NONNULL_END
