//
//  YSLChildViewControllerDelegate.h
//  YSLContainerViewControllerDemo
//
//  Created by Romy on 6/19/15.
//  Copyright © 2015 h.yamaguchi. All rights reserved.
//

@import UIKit;

/*
 *  Delegate so child view controller can communicate with grandparent YSLContainerViewController
 */
@protocol YSLChildViewControllerDelegate <NSObject>

// Child view controller selects a value, moves it to the appropriate index in the container view
- (void)childViewController:(UIViewController *)childViewController
        didChooseIndexValue:(NSInteger)value;

@end
