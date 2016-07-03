//
//  CollectionListViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by Gabriel Lupu on 01/07/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "CollectionListViewController.h"
#import "CollectionCellsCollectionViewCell.h"

@interface CollectionListViewController ()

@property (nonatomic, strong) NSMutableArray *playListArray;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation CollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playListArray = [@[@"photo_sample_01",
                        @"photo_sample_02",
                        @"photo_sample_03",
                        @"photo_sample_04",
                        @"photo_sample_05",
                        @"photo_sample_06",
                        @"photo_sample_07",
                        @"photo_sample_08",
                        @"photo_sample_08",
                        @"photo_sample_08"] mutableCopy];
    
    [self.myCollectionView reloadData];
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
    return _playListArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma -mark Create The Cells and Customizations when press
- (CollectionCellsCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCellsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellsCollectionViewCell" forIndexPath:indexPath];
    
    [cell.titleLabel setText:[NSString stringWithFormat:@"Playlist %ld",(long)indexPath.row]];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"photo_sample_0%ld",(long)indexPath.row]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
    return CGSizeMake(self.view.frame.size.width, 80);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(iAmScrollingWithContentOffset:)])
    {
        [self.delegate iAmScrollingWithContentOffset:scrollView.contentOffset.y];
    }
}


@end
