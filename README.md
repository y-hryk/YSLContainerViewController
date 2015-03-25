# YSLContainerViewController

## Demo

## Requirement

## Install

### Manually
Copy INBPullToRefresh directory to your project.

## Usage
     UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.title = @"viewController1";
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.title = @"viewController1";
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.title = @"viewController1";
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.title = @"viewController1";
    
     // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[playListVC,artistVC,sampleVC1,sampleVC2,sampleVC3]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];

   
## Property
## Licence
MIT
