//
//  FAGeTuiReceiver.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAGeTuiReceiver.h"
#import "FAGeTuiReceiverDelegate.h"


@implementation FAGeTuiReceiver

//获取FAGeTuiReceiver实例。
+(instancetype) shareInstance
{
    static FAGeTuiReceiver * receiver;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receiver = [[FAGeTuiReceiver alloc] init];
    });
    
    return receiver;
}

- (id)init
{
    self = [super init];  // Call a designated initializer here.
    if (self != nil)
    {
        receiverList = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) registerMessageReceiver:(id<FAGeTuiReceiverDelegate>) receiver
{
    [receiverList addObject:receiver];
}

-(void) receiveMessage:(NSString *)message
{
    NSLog(@"GeTuiReceiver message:%@",message);
    if(receiverList.count >0)
    {
        for (id<FAGeTuiReceiverDelegate> receiver in receiverList)
        {
            @try
            {
                [receiver receivePushMessage:message];
            }
            @catch (NSException *exception)
            {
                
            }
            @finally
            {
                
            }
        }
    }
}

@end
