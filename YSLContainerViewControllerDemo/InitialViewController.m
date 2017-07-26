//
//  InitialViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by Adeel Miraj on 26/07/2017.
//  Copyright © 2017 h.yamaguchi. All rights reserved.
//

#import "InitialViewController.h"
#import "ContainerViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapFirstViewControllerButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ContainerSegue" sender:[NSNumber numberWithInteger:0]];
}

- (IBAction)onTapSecondViewControllerButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ContainerSegue" sender:[NSNumber numberWithInteger:1]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ContainerViewController *containerVC = (ContainerViewController *)segue.destinationViewController;
    containerVC.defaultIndex = sender;
}

@end
