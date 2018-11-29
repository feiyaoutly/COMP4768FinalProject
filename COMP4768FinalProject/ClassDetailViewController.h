//
//  ClassDetailViewController.h
//  COMP4768FinalProject
//
//  Created by Feiya Ou on 2018-11-29.
//  Copyright © 2018 Feiya Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCHPersistenceManager.h"
#import "MSCHNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassDetailViewController : UIViewController
@property (strong,nonatomic) NSString *subject;
@property (strong,nonatomic) NSString *number;
@property (strong,nonatomic) NSString *section;
@end

NS_ASSUME_NONNULL_END
