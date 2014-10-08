//
//  FAMessage.h
//  FcpAssistant
//
//  Created by admin on 10/2/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAMessage.h"


@interface FAMessageDetail : NSObject

@property(nonatomic, assign) int SenderId;

@property(nonatomic, assign) ClientMessageType MessageType;

@property(nonatomic, copy) NSDate *Date;

@property(nonatomic, copy) NSString *DateString;

@property(nonatomic, retain) NSMutableArray *DetailList;

@end
