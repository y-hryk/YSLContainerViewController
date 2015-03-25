# YSLContainerViewController

## Demo

## Requirement

## Install

### Manually
Copy INBPullToRefresh directory to your project.

## Usage
    - (void)viewDidLoad {
        [super viewDidLoad];
        // SetUp ViewControllers
         PlayListTableViewController *playListVC = [[PlayListTableViewController alloc]initWithNibName:@"PlayListTableViewController" bundle:nil];
    playListVC.title = @"PlayList";
    
    ArtistsViewController *artistVC = [[ArtistsViewController alloc]initWithNibName:@"ArtistsViewController" bundle:nil];
    artistVC.title = @"Artists";
    
    SampleViewController *sampleVC1 = [[SampleViewController alloc]initWithNibName:@"SampleViewController" bundle:nil];
    sampleVC1.title = @"Album";
    
    SampleViewController *sampleVC2 = [[SampleViewController alloc]initWithNibName:@"SampleViewController" bundle:nil];
    sampleVC2.title = @"Track";
    
    SampleViewController *sampleVC3 = [[SampleViewController alloc]initWithNibName:@"SampleViewController" bundle:nil];
    sampleVC3.title = @"Setting";
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[playListVC,artistVC,sampleVC1,sampleVC2,sampleVC3]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
}


## Property
## Licence
MIT
