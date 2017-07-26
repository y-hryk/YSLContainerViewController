//
//  ContainerViewController.h
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property (nonatomic, nonnull) NSNumber *defaultIndex;

- (IBAction)goToNextViewController:(id _Nullable)sender;

@end

