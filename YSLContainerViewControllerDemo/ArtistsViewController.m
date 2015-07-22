//
//  ArtistsViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/25.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "ArtistsViewController.h"
#import "ArtistsCell.h"
#import "DetailViewController.h"

@interface ArtistsViewController ()

@property (nonatomic, strong) NSMutableArray *artistsArray;

@end

@implementation ArtistsViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"ArtistsViewController viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _artistsArray = [@[@"photo_sample_01",
                        @"photo_sample_02",
                        @"photo_sample_03",
                        @"photo_sample_04",
                        @"photo_sample_05",
                        @"photo_sample_06",
                        @"photo_sample_07",
                        @"photo_sample_08",
                        @"photo_sample_01",
                        @"photo_sample_02",
                        @"photo_sample_03",
                        @"photo_sample_04",
                        @"photo_sample_05",
                        @"photo_sample_06",
                        @"photo_sample_07",
                        @"photo_sample_08",] mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ArtistsCell" bundle:nil] forCellReuseIdentifier:@"ArtistsCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _artistsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         scellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ArtistsCell";
    ArtistsCell *cell = (ArtistsCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.artWorkImageView.image = [UIImage imageNamed:_artistsArray[indexPath.row]];
    cell.artisttNameLabel.text = [NSString stringWithFormat:@"Artists %ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
