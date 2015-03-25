//
//  YSLScrollMenuView.h
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSLScrollMenuViewDelegate <NSObject>

- (void)scrollMenuViewSelectedIndex:(NSInteger)index;

@end

@interface YSLScrollMenuView : UIView

@property (nonatomic, weak) id <YSLScrollMenuViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIFont *itemfont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) NSArray *itemTitleArray;
@property (nonatomic, strong) NSArray *itemViewArray;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemMargin;

// menu shadow
- (void)setShadowView;
- (CGPoint)selectItemCenter:(NSInteger)index;
- (void)setIndicatorViewFrame:(NSInteger)index;
- (void)setIndicatorViewFrame:(NSInteger)index ratio:(CGFloat)ratio isNextItem:(BOOL)isNextItem selectedIndex:(NSInteger)selectedIndex;

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex;
@end
