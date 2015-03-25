//
//  PlayListTableViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/25.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "PlayListCell.h"
#import "DetailViewController.h"

@interface PlayListTableViewController ()

@property (nonatomic, strong) NSMutableArray *playListArray;

@end

@implementation PlayListTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"PlayListTableViewController viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playListArray = [@[@"photo_sample_01",
                        @"photo_sample_02",
                        @"photo_sample_03",
                        @"photo_sample_04",
                        @"photo_sample_05",
                        @"photo_sample_06",
                        @"photo_sample_07",
                        @"photo_sample_08",] mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayListCell" bundle:nil] forCellReuseIdentifier:@"PlayListCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _playListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PlayListCell";
    PlayListCell *cell = (PlayListCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.artWorkImageView.image = [UIImage imageNamed:_playListArray[indexPath.row]];
    cell.playListNameLabel.text = [NSString stringWithFormat:@"PlayList %ld",(long)indexPath.row];
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
    return 80;
}

@end
