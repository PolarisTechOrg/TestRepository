//
//  FAGeTuiReceiverDelegate.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FAGeTuiReceiverDelegate;

@protocol FAGeTuiReceiverDelegate <NSObject>
@required
- (void)receivePushMessage:(NSString *)message;
@end