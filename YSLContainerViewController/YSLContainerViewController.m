//
//  YSLContainerViewController.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLContainerViewController.h"
#import "YSLScrollMenuView.h"

#define NAVIBAR_MENU_MEGIN 40

@interface YSLContainerViewController () <UIScrollViewDelegate, YSLScrollMenuViewDelegate>

@property (nonatomic, assign) CGFloat topBarHeight;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) YSLScrollMenuView *menuView;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLContainerViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (id)initWithControllers:(NSArray *)controllers
             topBarHeight:(CGFloat)topBarHeight
     parentViewController:(UIViewController *)parentViewController
{
    self = [super init];
    if (self) {
        
        [parentViewController addChildViewController:self];
        [self didMoveToParentViewController:parentViewController];
        
        _topBarHeight = topBarHeight;
        _titles = [[NSMutableArray alloc] init];
        _childControllers = [[NSMutableArray alloc] init];
        _childControllers = [controllers mutableCopy];
        
        NSMutableArray *titles = [NSMutableArray array];
        for (UIViewController *vc in _childControllers) {
            [titles addObject:[vc valueForKey:@"title"]];
        }
        _titles = [titles mutableCopy];
        
        [self layOutViews];
    }
    return self;
}

#pragma mark --
- (void)addControllerIndex:(NSInteger)index
{
    UIViewController *controller = (UIViewController*)self.childControllers[index];
    [self addChildViewController:controller];
    CGFloat scrollWidth = _contentScrollView.frame.size.width;
    CGFloat scrollHeght = _contentScrollView.frame.size.height;
    controller.view.frame = CGRectMake(index * scrollWidth, 0, scrollWidth, scrollHeght);
    [_contentScrollView addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    [self addControllerIndex:0];
}

- (void)removeControllerIndex:(NSInteger)index
{
    UIViewController *controller = (UIViewController*)self.childControllers[index];
    [controller addChildViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    [controller didMoveToParentViewController:nil];
}

// setupViews
- (void)layOutViews
{
    UIView *viewCover = [[UIView alloc]init];
    [self.view addSubview:viewCover];

    // ContentScrollview setup
    _contentScrollView = [[UIScrollView alloc]init];
    _contentScrollView.frame = CGRectMake(0,_topBarHeight + NAVIBAR_MENU_MEGIN, self.view.frame.size.width, self.view.frame.size.height - (_topBarHeight + NAVIBAR_MENU_MEGIN));
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * self.childControllers.count, _contentScrollView.frame.size.height);
    
    // ContentViewController setup
    for (int i = 0; i < self.childControllers.count; i++) {
        id object = [self.childControllers objectAtIndex:i];
        if ([object isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)object;
            [self addChildViewController:controller];
            [controller didMoveToParentViewController:self];
            CGFloat scrollWidth = _contentScrollView.frame.size.width;
            CGFloat scrollHeght = _contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [_contentScrollView addSubview:controller.view];
        }
    }
    
    // meunView
    _menuView = [[YSLScrollMenuView alloc]initWithFrame:CGRectMake(0, _topBarHeight, CGRectGetWidth(self.view.frame), NAVIBAR_MENU_MEGIN)];
    _menuView.backgroundColor = [UIColor clearColor];
    _menuView.delegate = self;
    [_menuView setItemTitleArray:self.titles];
    [self.view addSubview:_menuView];
    [_menuView setShadowView];
    
    
    [self scrollMenuViewSelectedIndex:0];
}

#pragma mark -- YSLScrollMenuView Delegate

- (void)scrollMenuViewSelectedIndex:(NSInteger)index
{
//    UILabel *previousItem = _menuView.itemViewArray[self.currentIndex];
//    UILabel *nextItem = _menuView.itemViewArray[index];
    
    if (abs((int)self.currentIndex - (int)index) <= 1) {
        [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.frame.size.width, 0) animated:YES];
    } else {
        [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.frame.size.width, 0.) animated:YES];
    }
    self.currentIndex = index;
    
    [_menuView setItemTextColor:[UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0]
           seletedItemTextColor:[UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0]
                   currentIndex:self.currentIndex];
}

#pragma mark -- ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat oldX = self.currentIndex * CGRectGetWidth(scrollView.frame);
    CGFloat ratio = (scrollView.contentOffset.x - oldX) / CGRectGetWidth(scrollView.frame);
    
    BOOL isToNextItem = (_contentScrollView.contentOffset.x > oldX);
    NSInteger targetIndex = (isToNextItem) ? self.currentIndex + 1 : self.currentIndex - 1;
    
    CGFloat nextItemOffsetX = 1.0f;
    CGFloat currentItemOffsetX = 1.0f;
    
    nextItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * targetIndex / (_menuView.itemViewArray.count - 1);
    currentItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * self.currentIndex / (_menuView.itemViewArray.count - 1);
    
    if (targetIndex >= 0 && targetIndex < self.childControllers.count) {
        // MenuView Move
        CGFloat indicatorUpdateRatio = ratio;
        if (isToNextItem) {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = (nextItemOffsetX - currentItemOffsetX) * ratio + currentItemOffsetX;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * 1;
            [_menuView setIndicatorViewFrame:targetIndex ratio:indicatorUpdateRatio isNextItem:isToNextItem selectedIndex:self.currentIndex];
        } else {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = currentItemOffsetX - (nextItemOffsetX - currentItemOffsetX) * ratio;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * -1;
            [_menuView setIndicatorViewFrame:self.currentIndex ratio:indicatorUpdateRatio isNextItem:isToNextItem selectedIndex:targetIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(_contentScrollView.frame);
    
    [_menuView setItemTextColor:[UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0]
           seletedItemTextColor:[UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0]
                   currentIndex:self.currentIndex];
}

@end
