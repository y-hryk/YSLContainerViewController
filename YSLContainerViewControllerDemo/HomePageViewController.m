//
//  HomePageViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by Gabriel Lupu on 30/06/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "HomePageViewController.h"
#import "ViewController.h"
#import "HomePageCollectionViewCell.h"

@interface HomePageViewController ()

@property (nonatomic,strong) NSArray *titlesArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = @[@"PlayList",@"Artists",@"Album", @"Track",@"Settings",];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark CollectionViewDelegate Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma -mark Create The Cells and Customizations when press
- (HomePageCollectionViewCell *)collectionView:(UICollectionView *)collectionView
        cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionViewCell" forIndexPath:indexPath];
    
    [cell.titleLabel setText:self.titlesArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    vc.indexMenu = (int)indexPath.row;
    vc.titlesArray = self.titlesArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
    return CGSizeMake(self.view.frame.size.width, 100);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
