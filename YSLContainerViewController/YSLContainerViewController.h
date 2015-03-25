//
//  YSLContainerViewController.h
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSLContainerViewController : UIViewController


@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong, readonly) NSMutableArray *titles;
@property (nonatomic, strong, readonly) NSMutableArray *childControllers;

- (id)initWithControllers:(NSArray *)controllers
             topBarHeight:(CGFloat)topBarHeight
     parentViewController:(UIViewController *)parentViewController;

@end
