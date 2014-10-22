//
//  FAAppDelegate.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAAppDelegate.h"
#import "FAMainController.h"
#import "FAJingXuanController.h"
#import "FAStrategyController.h"
#import "FATradeController.h"
#import "FAMessageController.h"
#import "FAMoreController.h"
#import "FAFoundation.h"
#import "WXApi.h"

#import <ShareSDK/ShareSDK.h>

@implementation FAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"3e1d7841faa0"];
    
    [ShareSDK connectWeChatWithAppId:@"wxb9642874c48edc0c" wechatCls:[WXApi class]];
    [ShareSDK connectSinaWeiboWithAppKey:@"1224842810" appSecret:@"364cd352be2ac3f03c7d15a656bacb23" redirectUri:@"http://www.sharesdk.cn"];
    // ShareSDK setup
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (CURRENT_SYS_VERSION >= 7.0)
    {
       //self.window.frame = CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
    }
    
    FAMainController * mainController = [[FAMainController alloc] init];
    self.window.rootViewController = mainController;
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// handleOpenURL with ShareSDK
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}

@end
