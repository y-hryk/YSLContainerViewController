//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLScrollMenuView.h"

@interface YSLScrollMenuView ()

@end

@implementation YSLScrollMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemfont = [UIFont fontWithName:@"Futura-Medium" size:16];
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        _itemWidth = 90;
        _itemMargin = 10;
    }
    return self;
}

- (CGPoint)selectItemCenter:(NSInteger)index
{
    CGPoint center = ((UIView *)self.itemViewArray[index]).center;
    CGFloat totalOffset = self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame);
    CGFloat offset = index * totalOffset / (self.itemViewArray.count - 1);
    center.x -= offset - (CGRectGetMinX(self.scrollView.frame));
    return center;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        
        for (int i = 0; i < itemTitleArray.count; i++) {
            CGRect frame = CGRectMake(0, 0, _itemWidth, CGRectGetHeight(self.frame));
            UILabel *itemView = [[UILabel alloc] initWithFrame:frame];
            [self.scrollView addSubview:itemView];
            itemView.tag = i;
            itemView.text = itemTitleArray[i];
            itemView.userInteractionEnabled = YES;
            itemView.backgroundColor = [UIColor clearColor];
            itemView.textAlignment = NSTextAlignmentCenter;
            itemView.font = self.itemfont;
            itemView.textColor = [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0];
           // itemView.textColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
            [views addObject:itemView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapAction:)];
            [itemView addGestureRecognizer:tapGesture];
        }
        
        // indicator
        _indicatorView = [[UIView alloc]init];
        _indicatorView.frame = CGRectMake(10, _scrollView.frame.size.height - 3, _itemWidth, 3);
        _indicatorView.backgroundColor = [UIColor colorWithRed:0.168627 green:0.498039 blue:0.839216 alpha:1.0];
        [_scrollView addSubview:_indicatorView];
        
        self.itemViewArray = [NSArray arrayWithArray:views];
    }
}

- (void)setIndicatorViewFrame:(NSInteger)index
{
    UIView *view = self.itemViewArray[index];
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _indicatorView.frame = CGRectMake(view.frame.origin.x, _scrollView.frame.size.height - 3, 90, 3);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)setIndicatorViewFrame:(NSInteger)index ratio:(CGFloat)ratio isNextItem:(BOOL)isNextItem selectedIndex:(NSInteger)selectedIndex
{
//    UIView *view = self.itemViewArray[index];
//    UIView *selectedView = self.itemViewArray[selectedIndex];
    
    CGFloat indicatorX = 0.0;
    if (isNextItem) {
        indicatorX = ((_itemMargin + _itemWidth) * ratio ) + (selectedIndex * _itemWidth) + ((selectedIndex + 1) * _itemMargin);
    } else {
        indicatorX =  ((_itemMargin + _itemWidth) * (1 - ratio) ) + (selectedIndex * _itemWidth) + ((selectedIndex + 1) * _itemMargin);
    }
    
    if (indicatorX < _itemMargin || indicatorX > self.scrollView.contentSize.width - (_itemMargin + _itemWidth)) {
        return;
    }
    _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - 3, _itemWidth, 3);
    NSLog(@"retio : %f",_indicatorView.frame.origin.x);
}


- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UILabel *label = self.itemViewArray[i];
        if (i == currentIndex) {
            label.textColor = selectedItemTextColor;
        } else {
            label.textColor = itemTextColor;
        }
    }
}

// menu shadow
- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

//- (CGSize)layoutMenuLabel:(NSString *)title
//{
//    CGSize size;
//    NSDictionary *attributeDic = @{NSFontAttributeName:self.itemfont};
//    size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
//                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
//                               attributes:attributeDic
//                                  context:nil].size;
//                                   
//    CGSize totalSize = CGSizeMake((int)size.width, CGRectGetHeight(self.frame));
//    return totalSize;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat x = 0.0f;
//    for (int i = 0; i < self.itemViewArray.count; i ++) {
//        x += 320 / 3;
//        UILabel *itemView = self.itemViewArray[i];
//        itemView.frame = CGRectMake(x, 0, 320 / 3, CGRectGetHeight(self.frame));
//    }
//    self.scrollView.contentSize = CGSizeMake(x + (320 / 3) * 2, 30);
    
//    CGFloat x = 0.0f;
//    for (int i = 0; i < self.itemViewArray.count; i ++) {
//        
//    }
    CGFloat margin = _itemMargin;
    
    CGFloat x = margin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
       // CGFloat width = [self layoutMenuLabel:self.itemTitleArray[i]].width;
        CGFloat width = _itemWidth;
        UIView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(x, 0, width, CGRectGetHeight(self.frame));
        x += width + margin;
    }
    self.scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(self.scrollView.frame));
    
    CGRect frame = self.scrollView.frame;
    if (CGRectGetWidth(self.frame) > x) {
        frame.origin.x = (CGRectGetWidth(self.frame) - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = CGRectGetWidth(self.frame);
    }
    self.scrollView.frame = frame;
}

#pragma mark -- Selector --------------------------------------- //
- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
    }
}

@end
