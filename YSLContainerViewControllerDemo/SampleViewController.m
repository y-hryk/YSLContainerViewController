//
//  SampleViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/25.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(childViewController:didChooseIndexValue:)]) {
        // put it to index one for now
        [self.delegate childViewController:self didChooseIndexValue:0];
    }
}

@end
