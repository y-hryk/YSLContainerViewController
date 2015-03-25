//
//  ViewController.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "ViewController.h"
#import "YSLContainerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.font = [UIFont fontWithName:@"Futura-Medium" size:19];
    titleView.textColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
    titleView.text = @"Page Menu";
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    
    UIViewController *vc1 = [[UIViewController alloc]init];
    UIViewController *vc2 = [[UIViewController alloc]init];
    UIViewController *vc3 = [[UIViewController alloc]init];
    UIViewController *vc4 = [[UIViewController alloc]init];
    UIViewController *vc5 = [[UIViewController alloc]init];
    
    vc1.view.backgroundColor = [UIColor redColor];
    vc2.view.backgroundColor = [UIColor orangeColor];
    vc3.view.backgroundColor = [UIColor greenColor];
    vc4.view.backgroundColor = [UIColor purpleColor];
    vc5.view.backgroundColor = [UIColor lightGrayColor];
    
    vc1.title = @"PlayList";
    vc2.title = @"Artists";
    vc3.title = @"Track";
    vc4.title = @"Album";
    vc5.title = @"Setting";
    
    YSLContainerViewController *container = [[YSLContainerViewController alloc]initWithControllers:@[vc1,vc2,vc3,vc4,vc5]
                                                                                      topBarHeight:64
                                                                              parentViewController:self];
    [self.view addSubview:container.view];
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
