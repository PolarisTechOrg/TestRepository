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
#import "FAGeTuiReceiver.h"
#import <ShareSDK/ShareSDK.h>
#import "FAUtility.h"
#import "FAAccountManager.h"
#define kAppId           @"xvCjiiXt6l5mRuOnwPHIE2"
#define kAppKey          @"ckYFmh6xik8zSRKud5rTv1"
#define kAppSecret       @"sUjtC4k1MW8bYr7bNpSOe7"

@implementation FAAppDelegate

@synthesize gexinPusher = _gexinPusher;
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize appID = _appID;
//@synthesize clientId = _clientId;
@synthesize sdkStatus = _sdkStatus;
@synthesize lastPayloadIndex = _lastPaylodIndex;
@synthesize payloadId = _payloadId;

- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

- (NSString *)currentLogFilePath
{
    NSMutableArray * listing = [NSMutableArray array];
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray * fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDirectory error:nil];
    if (!fileNames) {
        return nil;
    }
    
    for (NSString * file in fileNames) {
        if (![file hasPrefix:@"_log_"]) {
            continue;
        }
        
        NSString * absPath = [docsDirectory stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:absPath isDirectory:&isDir]) {
            if (isDir) {
                [listing addObject:absPath];
            } else {
                [listing addObject:absPath];
            }
        }
    }
    
    [listing sortUsingComparator:^(NSString *l, NSString *r) {
        return [l compare:r];
    }];
    
    if (listing.count) {
        return [listing objectAtIndex:listing.count - 1];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //分享设置
    {
        [ShareSDK registerApp:@"3e1d7841faa0"];
        
        //    [ShareSDK importWeChatClass:[WXApi class]];
        [ShareSDK connectWeChatWithAppId:@"wxb9642874c48edc0c" wechatCls:[WXApi class]];
        [ShareSDK connectSinaWeiboWithAppKey:@"1224842810" appSecret:@"364cd352be2ac3f03c7d15a656bacb23" redirectUri:@"http://www.sharesdk.cn"];
        // ShareSDK setup
    }
    
    {
        //个推设置
        // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
        [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
        
        // [2]:注册APNS
        [self registerRemoteNotification];
        
        // [2-EXT]: 获取启动时收到的APN
        NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (message)
        {
            NSString *payloadMsg = [message objectForKey:@"payload"];
            NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
            [[FAGeTuiReceiver shareInstance] receiveMessage:record];
        }
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    
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
    // [EXT] 切后台关闭SDK，让SDK第一时间断线，让个推先用APN推送
    [self stopSdk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // [EXT] 重新上线
    [self startSdkWith:_appID appKey:_appKey appSecret:_appSecret];
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceTokenStr =[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [FAAccountManager shareInstance].deviceToken = deviceTokenStr;
    NSLog(@"deviceToken:%@", deviceTokenStr);
    
    // [3]:向个推服务器注册deviceToken
    @try
    {
        if (_gexinPusher)
        {
            [_gexinPusher registerDeviceToken:deviceTokenStr];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"RegisterForRemoteNotificationsWithDeviceToken failed:%@", exception.description);
    }
    @finally
    {
        
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    if (_gexinPusher)
    {
        [_gexinPusher registerDeviceToken:@""];
    }
    
    [FAUtility showAlterView:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
//    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
//    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    
    //程序处于运行状态不转发APN消息
//    [[FAGeTuiReceiver shareInstance] receiveMessage:record];
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher)
    {
        _sdkStatus = SdkStatusStoped;
        
        self.appID = appID;
        self.appKey = appKey;
        self.appSecret = appSecret;
        

        
        NSError *err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:_appID appKey:_appKey appSecret:_appSecret
                                         appVersion:@"0.0.0" delegate:self error:&err];
        if (!_gexinPusher)
        {
            [FAUtility showAlterView:[NSString stringWithFormat:@"%@", [err localizedDescription]]];
        }
        else
        {
            _sdkStatus = SdkStatusStarting;
        }
    }
}

- (void)stopSdk
{
    if (_gexinPusher)
    {
        [_gexinPusher destroy];
        _gexinPusher = nil;
        _sdkStatus = SdkStatusStoped;
    }
}

- (BOOL)checkSdkInstance
{
    if (!_gexinPusher)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"SDK未启动" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSdkInstance])
    {
        return;
    }
    
    [_gexinPusher registerDeviceToken:aToken];
}

- (BOOL)setTags:(NSArray *)aTags error:(NSError **)error
{
    if (![self checkSdkInstance])
    {
        return NO;
    }
    
    return [_gexinPusher setTags:aTags];
}

- (NSString *)sendMessage:(NSData *)body error:(NSError **)error
{
    if (![self checkSdkInstance])
    {
        return nil;
    }
    
    return [_gexinPusher sendMessage:body error:error];
}


#pragma mark - GexinSdkDelegate
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册
    _sdkStatus = SdkStatusStarted;
    [FAAccountManager shareInstance].geTuiClientId = clientId;
    
    NSLog(@"GexinSdkDidRegisterClient ClientID:%@",clientId);
}

- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    _payloadId = payloadId;
    
    NSData *payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload)
    {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
    }
    NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++_lastPaylodIndex, [NSDate date], payloadMsg];
    [[FAGeTuiReceiver shareInstance] receiveMessage:record];
}

- (void)GexinSdkDidSendMessage:(NSString *)messageId result:(int)result
{
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    [[FAGeTuiReceiver shareInstance] receiveMessage:record];
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    [FAUtility showAlterView:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]];
}

@end
