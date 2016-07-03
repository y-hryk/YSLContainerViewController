//
//  ViewController.m
//  YSLContainerViewControllerDemo
//
//  Created by yamaguchi on 2015/03/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//
// image download from: http://all-free-download.com/free-photos/download/artist_mother_nature_555965_download.html

#import "ViewController.h"
#import "YSLContainerViewController.h"
#import "CollectionListViewController.h"
#import "Constants.h"

static const float minimumHeight = 64.0f;

@interface ViewController () <YSLContainerViewControllerDelegate,ScrollCategoryDelegate>
{
    float heightInitial;
    int currentIndex;
}


@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfView;
@property (nonnull,strong) UIVisualEffectView *blurEffectView;
@property (nonatomic,strong) UILabel *middleTitle;
@property (nonatomic,strong) UILabel *titleText;
@property (nonatomic,strong) UIButton *backButton;

@property (nonatomic,strong) YSLContainerViewController *containerVC;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButtonToScreen];
    heightInitial = self.heightOfView.constant;
//    int widthOfScreen = (int)self.view.frame.size.width;
//    switch (widthOfScreen) {
//        case 414:
//        {
//            heightInitial = 212;
//            self.heightOfView.constant = 212;
//            [self.topView layoutIfNeeded];
//        }
//            break;
//        case 375:
//        {
//            self.heightOfView.constant = 192;
//            heightInitial = 192;
//            [self.topView layoutIfNeeded];
//        }
//            break;
//        case 320:
//        {
//            self.heightOfView.constant = 164;
//            heightInitial = 164;
//            [self.topView layoutIfNeeded];
//        }
//            break;
//            
//        default:
//        {
//            
//        }
//            break;
//    }
    
    NSMutableArray *viewControllersArray = [[NSMutableArray alloc] init];
    for (int i=0; i< [self.titlesArray count]; i++)
    {
        CollectionListViewController *playListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionListViewController"];
        playListVC.title = self.titlesArray[i];
        playListVC.delegate = self;
        [viewControllersArray addObject:playListVC];
    }
    
    // ContainerView
    float statusHeight = 0;
    float navigationHeight = 0;
    self.containerVC = [[YSLContainerViewController alloc]initWithControllers:viewControllersArray
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self
                                                                                        heightOfView:self.view.frame.size.height - self.heightOfView.constant];
    self.containerVC.delegate = self;
    self.containerVC.menuItemFont = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    self.containerVC.menuItemSelectedTitleColor = [UIColor colorWithRed:171.0f/255.0f green:4.0f/255.0f blue:16.0f/255.0f alpha:1.0];
    self.containerVC.menuItemTitleColor = [UIColor colorWithRed:162.0f/255.0f green:162.0/255.0f blue:169.0f/255.0f alpha:1];
    self.containerVC.menuIndicatorColor = [UIColor colorWithRed:171.0f/255.0f green:4.0f/255.0f blue:16.0f/255.0f alpha:1.0];
    
    self.containerVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.bottomView.frame.size.height);
    [self.bottomView addSubview:self.containerVC.view];
    
    NSLayoutConstraint *myConstraint1 = [NSLayoutConstraint constraintWithItem:self.containerVC.view
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.bottomView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0];
    NSLayoutConstraint *myConstraint2 = [NSLayoutConstraint constraintWithItem:self.containerVC.view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.bottomView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0];
    NSLayoutConstraint *myConstraint3 = [NSLayoutConstraint constraintWithItem:self.containerVC.view
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.bottomView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:0];
    NSLayoutConstraint *myConstraint4 = [NSLayoutConstraint constraintWithItem:self.containerVC.view
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.bottomView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0];
    [self.bottomView addConstraint:myConstraint1];
    [self.bottomView addConstraint:myConstraint2];
    [self.bottomView addConstraint:myConstraint3];
    [self.bottomView addConstraint:myConstraint4];

    
    self.middleTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130,85, 260, 37)];
    self.middleTitle.textColor = [UIColor whiteColor];
    self.middleTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:31];
    self.middleTitle.textAlignment = NSTextAlignmentCenter;
    
    currentIndex = 0;
    self.middleTitle.text = self.titlesArray[currentIndex];
    self.titleText.text = self.titlesArray[currentIndex];
    
    [self.topView addSubview:self.middleTitle];
    [self.view insertSubview:self.titleText aboveSubview:self.blurEffectView];
    
    [self.containerVC goToSelectedViewController:self.indexMenu];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    currentIndex = (int)index;
    if (currentIndex < [self.titlesArray count])
    {
        
        self.middleTitle.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.37];
        self.middleTitle.shadowOffset = CGSizeMake(1, 1);
        self.middleTitle.layer.masksToBounds = NO;
        
        self.middleTitle.text = self.titlesArray[currentIndex];
        self.titleText.text = self.titlesArray[currentIndex];
        
        switch (currentIndex)
        {
            case 0:
            {
                [UIView transitionWithView:self.topView
                                  duration:1.0f
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    self.topView.image = [UIImage imageNamed:@"barbie-1426039_1280.jpg"];
                                } completion:nil];
            }
                break;
                case 1:
                {
                    [UIView transitionWithView:self.topView
                                      duration:1.0f
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        self.topView.image = [UIImage imageNamed:@"grapes-1476089_1280.jpg"];
                                    } completion:nil];
                }
                    break;
                case 2:
                {
                    [UIView transitionWithView:self.topView
                                      duration:1.0f
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        self.topView.image = [UIImage imageNamed:@"sport-shoe-1470061_1280.jpg"];
                                    } completion:nil];
                }
                    break;
            default:
                break;
        }
        
        
    }
}

- (void) iAmScrollingWithContentOffset:(CGFloat) contentOffset
{
    if (contentOffset < 0)
    {
        self.middleTitle.alpha = 1 + contentOffset/100;
        [UIView animateWithDuration:0.0 animations:^{
            self.middleTitle.frame = CGRectMake(self.view.frame.size.width/2 - 130,85, 260, 37);
        }];
    }
    else if (contentOffset > 0)
    {
        self.middleTitle.alpha = 1 - contentOffset/100;
        
        [UIView animateWithDuration:0.0 animations:^{
            self.middleTitle.frame = CGRectMake(self.view.frame.size.width/2 - 130,85 - contentOffset/2.0f, 260, 37);
        }];
    }

    if (heightInitial - contentOffset >= minimumHeight)
    {
        self.heightOfView.constant = heightInitial - contentOffset;
        
        if (self.blurEffectView || self.titleText)
        {
            [self.blurEffectView removeFromSuperview];
            [self.titleText removeFromSuperview];
        }
    }
    else
    {
        self.heightOfView.constant = minimumHeight;
        [self addBlurView];
    }
    [self.topView layoutIfNeeded];
    
    if (contentOffset>=0)
    {
        CGRect rect = self.containerVC.contentScrollView.frame;
        rect.size.height = self.view.frame.size.height - self.heightOfView.constant - kYSLScrollMenuViewHeight;
        self.containerVC.contentScrollView.frame = rect;
    }
}

- (void) addBlurView
{
    if (!UIAccessibilityIsReduceTransparencyEnabled())
    {
        if (!self.blurEffectView)
        {
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            self.blurEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        }
        
        if (!self.titleText)
        {
            self.titleText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 0, 120, 44)];
            self.titleText.textColor = [UIColor whiteColor];
            self.titleText.font = [UIFont fontWithName:@"Helvetica" size:16];
            self.titleText.textAlignment = NSTextAlignmentCenter;
            self.titleText.text = self.titlesArray[currentIndex];
        }
        
        [self.view insertSubview:self.blurEffectView belowSubview:self.backButton];
        [self.view insertSubview:self.titleText aboveSubview:self.blurEffectView];
        
        [UIView animateWithDuration:0.01 animations:^{
            self.titleText.frame = CGRectMake(self.view.frame.size.width/2 - 60, 20, 120, 44);
        }];
    }
}

- (void) backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addBackButtonToScreen
{
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.2, 34, 16.3, 15)];
    [self.backButton addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"chevron"]];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
}

@end
