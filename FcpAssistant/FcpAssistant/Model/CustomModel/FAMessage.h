//
//  FAMessage.h
//  FcpAssistant
//
//  Created by admin on 10/2/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAClientMessageDto.h"

@interface FAMessage : NSObject

@property(nonatomic, assign) bool ReadFlag;

@property(nonatomic, assign) int MessageId;

@property(nonatomic, assign) ClientMessageType MessageType;

@property(nonatomic, assign) int SenderId;

@property(nonatomic, copy) NSString *SenderName;

@property(nonatomic, copy) NSDate *MessageTime;

@property(nonatomic, copy) NSString *MessageTimeString;

@property(nonatomic, copy) NSString *Context;


- (NSComparisonResult)compareDate:(FAMessage *)element;

@end
