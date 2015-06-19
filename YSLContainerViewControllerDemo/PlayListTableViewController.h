//
//  PlayListTableViewController.h
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/25.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLChildViewControllerDelegate.h"

@interface PlayListTableViewController : UITableViewController

@property (weak, nonatomic) id <YSLChildViewControllerDelegate> delegate;

@end
