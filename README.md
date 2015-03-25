# YSLContainerViewController

## Demo

## Requirement

## Install

 #### Manually
 Copy INBPullToRefresh directory to your project.

## Usage

    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.title = @"vc1";
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.title = @"vc2";
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.title = @"vc3";
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.title = @"vc4";
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[vc1,vc2,vc3,vc4]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    [self.view addSubview:containerVC.view];

## Property
## Licence
MIT
