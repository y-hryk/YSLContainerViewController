# YSLContainerViewController

## Demo
![Dome](https://raw.githubusercontent.com/y-hryk/YSLContainerViewController/master/sample.gif)
## Requirement
not support landscape
## Install
#### Manually
 Copy YSLContainerViewController directory to your project.
#### CocoaPods
 Add pod 'YSLContainerViewController' to your Podfile.
 
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
    
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    containerVC.menuItemTitleColor = [UIColor whiteColor];
    containerVC.menuItemSelectedTitleColor = [UIColor redColor];
    containerVC.menuIndicatorColor = [UIColor yellowColor];
    containerVC.menuBackGroudColor = [UIColor purpleColor];
    
## Licence
MIT
