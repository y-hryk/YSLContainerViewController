//
//  YSLContainerViewController.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLContainerViewController.h"
#import "YSLScrollMenuView.h"
#import <PureLayout.h>

static const CGFloat kYSLScrollMenuViewHeight = 40;

@interface YSLContainerViewController () <UIScrollViewDelegate, YSLScrollMenuViewDelegate>

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *childControllers;
@property (nonatomic, assign) CGFloat topBarHeight;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) YSLScrollMenuView *menuView;

@end

@implementation YSLContainerViewController

- (id)initWithControllers:(NSArray *)controllers
             topBarHeight:(CGFloat)topBarHeight
     parentViewController:(UIViewController *)parentViewController
{
    self = [super init];
    if (self) {
        
        [parentViewController addChildViewController:self];
        [self didMoveToParentViewController:parentViewController];
        
        _topBarHeight = topBarHeight;
        _childControllers = controllers;
        
        NSMutableArray *titles = [NSMutableArray array];
        for (UIViewController *vc in _childControllers) {
            [titles addObject:[vc valueForKey:@"title"]];
        }
        _titles = titles;
    }
    return self;
}

-(UIScrollView *)contentScrollView{
    
    if(!_contentScrollView){
        
        _contentScrollView = [[UIScrollView alloc]init];
        
        _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.scrollsToTop = NO;
    }
    
    return _contentScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ContentScrollview setup
    
    self.contentScrollView.delegate = self;
    
    self.contentScrollView.frame = CGRectMake(0,_topBarHeight + kYSLScrollMenuViewHeight, self.view.frame.size.width, self.view.frame.size.height - (_topBarHeight + kYSLScrollMenuViewHeight));
    
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width * self.childControllers.count, self.contentScrollView.frame.size.height);

    
    // ContentViewController setup
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = [self.childControllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            CGFloat scrollWidth = self.contentScrollView.frame.size.width;
            CGFloat scrollHeght = self.contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [self.contentScrollView addSubview:controller.view];
        }
    }
    // meunView
    self.menuView = [[YSLScrollMenuView alloc]initWithFrame:CGRectMake(0, _topBarHeight, self.view.frame.size.width, kYSLScrollMenuViewHeight)];
    self.menuView.backgroundColor = [UIColor clearColor];
    self.menuView.delegate = self;
    self.menuView.viewbackgroudColor = self.menuBackGroudColor;
    self.menuView.itemfont = self.menuItemFont;
    self.menuView.itemTitleColor = self.menuItemTitleColor;
    self.menuView.itemIndicatorColor = self.menuIndicatorColor;
    self.menuView.scrollView.scrollsToTop = NO;
    
    self.menuView.itemTitleArray = self.titles;
    [self.view addSubview:self.menuView];
    [self.menuView setShadowView];
    
    [self scrollMenuViewSelectedIndex:0];
}

#pragma mark -- private

- (void)setChildViewControllerWithCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = self.childControllers[i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            if (i == currentIndex) {
//                [controller willMoveToParentViewController:self];
                [self addChildViewController:controller];
                [controller didMoveToParentViewController:self];
            } else {
                [controller willMoveToParentViewController:self];
                [controller removeFromParentViewController];
                [controller didMoveToParentViewController:self];
            }
        }
    }
}
#pragma mark -- YSLScrollMenuView Delegate

- (void)scrollMenuViewSelectedIndex:(NSInteger)index
{
    [self.contentScrollView setContentOffset:CGPointMake(index * self.contentScrollView.frame.size.width, 0.) animated:YES];
    
    // item color
    [self.menuView setItemTextColor:self.menuItemTitleColor
           seletedItemTextColor:self.menuItemSelectedTitleColor
                   currentIndex:index];
    
    [self setChildViewControllerWithCurrentIndex:index];
    
    if (index == self.currentIndex) { return; }
    self.currentIndex = index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(containerViewItemIndex:currentController:)]) {
        [self.delegate containerViewItemIndex:self.currentIndex currentController:_childControllers[self.currentIndex]];
    }
}

#pragma mark -- ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat oldPointX = self.currentIndex * scrollView.frame.size.width;
    CGFloat ratio = (scrollView.contentOffset.x - oldPointX) / scrollView.frame.size.width;
    
    BOOL isToNextItem = (self.contentScrollView.contentOffset.x > oldPointX);
    NSInteger targetIndex = (isToNextItem) ? self.currentIndex + 1 : self.currentIndex - 1;
    
    CGFloat nextItemOffsetX = 1.0f;
    CGFloat currentItemOffsetX = 1.0f;
    
    nextItemOffsetX = (self.menuView.scrollView.contentSize.width - self.menuView.scrollView.frame.size.width) * targetIndex / (self.menuView.itemViewArray.count - 1);
    currentItemOffsetX = (self.menuView.scrollView.contentSize.width - self.menuView.scrollView.frame.size.width) * self.currentIndex / (self.menuView.itemViewArray.count - 1);
    
    if (targetIndex >= 0 && targetIndex < self.childControllers.count) {
        // MenuView Move
        CGFloat indicatorUpdateRatio = ratio;
        if (isToNextItem) {
            
            CGPoint offset = self.menuView.scrollView.contentOffset;
            offset.x = (nextItemOffsetX - currentItemOffsetX) * ratio + currentItemOffsetX;
            [self.menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * 1;
            [self.menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:self.currentIndex];
        } else {
            
            CGPoint offset = self.menuView.scrollView.contentOffset;
            offset.x = currentItemOffsetX - (nextItemOffsetX - currentItemOffsetX) * ratio;
            [self.menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * -1;
            [self.menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:targetIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentIndex = scrollView.contentOffset.x / self.contentScrollView.frame.size.width;
    
    if (currentIndex == self.currentIndex) { return; }
    self.currentIndex = currentIndex;
    
    // item color
    [self.menuView setItemTextColor:self.menuItemTitleColor
           seletedItemTextColor:self.menuItemSelectedTitleColor
                   currentIndex:currentIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(containerViewItemIndex:currentController:)]) {
        [self.delegate containerViewItemIndex:self.currentIndex currentController:_childControllers[self.currentIndex]];
    }
    [self setChildViewControllerWithCurrentIndex:self.currentIndex];
}

@end
