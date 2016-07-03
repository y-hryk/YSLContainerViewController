//
//  CollectionListViewController.h
//  YSLContainerViewControllerDemo
//
//  Created by Gabriel Lupu on 01/07/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollWithContentDelegate <NSObject>

- (void) scrollingWithContentOffset:(CGFloat) contentOffset;

@end

@interface CollectionListViewController : UIViewController

@property id<ScrollWithContentDelegate> delegate;

@end
