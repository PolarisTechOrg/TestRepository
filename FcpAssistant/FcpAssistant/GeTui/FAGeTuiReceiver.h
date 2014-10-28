//
//  FAGeTuiReceiver.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FAGeTuiReceiver : NSObject
{
    NSMutableArray *receiverList;
}

+(instancetype) shareInstance;

-(void) registerMessageReceiver:(id) receiver;
-(void) receiveMessage:(NSString *)message;
@end
