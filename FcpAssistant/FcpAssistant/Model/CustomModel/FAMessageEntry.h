//
//  FAMessageEntry.h
//  FcpAssistant
//
//  Created by admin on 10/27/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAMessage.h"

@interface FAMessageEntry : NSObject

@property(nonatomic, assign) NSString *SenderId;

@property(nonatomic, assign) ClientMessageType MessageType;

@property(nonatomic, assign) BOOL ReadFlag;

@property(nonatomic, copy) NSString *DateString;

@property(nonatomic, retain) FAMessage *LatedMessage;

@end
