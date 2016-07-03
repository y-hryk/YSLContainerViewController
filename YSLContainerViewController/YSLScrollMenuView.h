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

@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, weak) id <YSLScrollMenuViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *itemTitleArray;
@property (nonatomic, strong) NSArray *itemViewArray;

@property (nonatomic, strong) UIColor *viewbackgroudColor;
@property (nonatomic, strong) UIFont *itemfont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *itemSelectedTitleColor;
@property (nonatomic, strong) UIColor *itemIndicatorColor;

- (void)setShadowView:(BOOL) hasShadow;
- (void)moveIndicatorViewToCurrentIndex:(NSInteger) index;
- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex;

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex;
@end
