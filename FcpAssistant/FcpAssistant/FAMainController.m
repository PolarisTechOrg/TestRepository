//
//  FAMainController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMainController.h"
#import "FAJingXuanController.h"
#import "FAStrategyController.h"
#import "FATradeController.h"
#import "FAMessageController.h"
#import "FAMoreController.h"
#import "FAFoundation.h"

@interface FAMainController ()

@end

@implementation FAMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FAJingXuanController * jingXuanController = [[FAJingXuanController alloc] init];
    jingXuanController.tabBarItem.title = @"精选";
    jingXuanController.tabBarItem.image = [UIImage imageNamed:@"JingXuan"];
    
    UINavigationController * navJingXuanController = [[UINavigationController alloc] initWithRootViewController:jingXuanController];
    navJingXuanController.tabBarItem.title = @"精选";
    navJingXuanController.tabBarItem.image = [UIImage imageNamed:@"JingXuan"];

    
    FAStrategyController * strategyController = [[FAStrategyController alloc] init];
    strategyController.tabBarItem.title = @"策略";
    strategyController.tabBarItem.image = [UIImage imageNamed:@"Strategy"];
    
    UINavigationController * navStrategyController = [[UINavigationController alloc] initWithRootViewController:strategyController];
    navStrategyController.tabBarItem.title = @"策略";
    navStrategyController.tabBarItem.image = [UIImage imageNamed:@"Strategy"];
    
    FATradeController * tradeController =[[FATradeController alloc] initWithNibName:@"FATradeController" bundle:nil];
    tradeController.tabBarItem.title= @"交易";
    tradeController.tabBarItem.image = [UIImage imageNamed:@"Trade"];

//    FAStrategyController * tradeController =[[FAStrategyController alloc] init];
//    tradeController.tabBarItem.title= @"交易";
//    tradeController.tabBarItem.image = [UIImage imageNamed:@"Trade"];
    
    UINavigationController * navTradeController = [[UINavigationController alloc] initWithRootViewController:tradeController];
    navTradeController.tabBarItem.title = @"交易";
    navTradeController.tabBarItem.image = [UIImage imageNamed:@"Trade"];
//    navTradeController.navigationBar.backgroundColor =[UIColor colorWithRed:84.0/255 green:38/255 blue:184.0/255 alpha:1.0];


//    navTradeController.navigationBar.tintColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    
    FAMessageController * messageController =[[FAMessageController alloc] init];
    messageController.tabBarItem.title = @"消息";
    messageController.tabBarItem.image = [UIImage imageNamed:@"Message"];
    messageController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", messageController.unReadCount];
    
    UINavigationController * navMessageController = [[UINavigationController alloc] initWithRootViewController:messageController];
    navMessageController.tabBarItem.title = @"消息";
    navMessageController.tabBarItem.image = [UIImage imageNamed:@"Message"];
    
    FAMoreController * moreController = [[FAMoreController alloc] init];
    moreController.tabBarItem.title = @"更多";
    moreController.tabBarItem.image = [UIImage imageNamed:@"More"];
    
    UINavigationController * navMoreController = [[UINavigationController alloc] initWithRootViewController:moreController];
    navMoreController.tabBarItem.title = @"更多";
    navMoreController.tabBarItem.image = [UIImage imageNamed:@"More"];
    
    // setup UI Image
    UIColor *color = [UIColor colorWithRed:0.176 green:0.576 blue:0.980 alpha:1.000];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"bg_menu"]];
    [self.tabBar setSelectedImageTintColor:color];
    
    if (CURRENT_SYS_VERSION >= 7.0)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:106.0/255 green:68.0/255 blue:209.0/255 alpha:1.0]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
    }
    else
    {
          [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:106.0/255 green:68.0/255 blue:209.0/255 alpha:1.0]];
    }
    
//    [[UINavigationBar appearance] setTranslucent:NO];


    
   
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
    
    self.viewControllers = [NSArray arrayWithObjects:navJingXuanController,navStrategyController,navTradeController,navMessageController,navMoreController,nil];
    //    mainController.tabBar.tintColor = [UIColor purpleColor];
    // setup UI Image
    //UIColor *color = [UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1.0];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBkg"]];
    //[self.tabBar setBackgroundColor:color];
    //wide 
    //[self.tabBar setSelectedImageTintColor: [UIColor colorWithRed:0.0 green:146.0/255 blue:1 alpha:1.0 ] ];
    
//    [self.tabBar setSelectedImageTintColor:[UIColor redColor]];

    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
