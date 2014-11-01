//
//  FAAppDelegate.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GexinSdk.h"

typedef enum {
    SdkStatusStoped,
    SdkStatusStarting,
    SdkStatusStarted
} SdkStatus;

@interface FAAppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate>
{
//        NSString *_deviceToken;
}

@property (strong, nonatomic) UIWindow *window;

//个推
@property (strong, nonatomic) GexinSdk *gexinPusher;

@property (retain, nonatomic) NSString *appKey;
@property (retain, nonatomic) NSString *appSecret;
@property (retain, nonatomic) NSString *appID;
//@property (retain, nonatomic) NSString *clientId;
@property (assign, nonatomic) SdkStatus sdkStatus;

@property (assign, nonatomic) int lastPayloadIndex;
@property (retain, nonatomic) NSString *payloadId;

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
- (void)stopSdk;

- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError **)error;
- (NSString *)sendMessage:(NSData *)body error:(NSError **)error;
@end
