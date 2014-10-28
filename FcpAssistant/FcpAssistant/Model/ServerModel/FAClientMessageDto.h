//
//  FAClientMessageDto.h
//  FcpAssistant
//
//  Created by admin on 9/30/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ClientMessageType
{
    Unknown = 0,
    
    SystemMessage = 1,
    
    StrategyMessage = 2,
    
    ProviderMessage = 3,
    
}ClientMessageType;


@interface FAClientMessageDto : NSObject

@property(nonatomic, assign) bool ReadFlag;

@property(nonatomic, assign) int MessageId;

@property(nonatomic, assign) ClientMessageType MessageType;

@property(nonatomic, assign) NSString *SenderId;

@property(nonatomic, copy) NSString *SenderName;

@property(nonatomic, copy) NSDate *MessageTime;

@property(nonatomic, copy) NSString *Context;

@end
