//
//  FAMessage.m
//  FcpAssistant
//
//  Created by admin on 10/2/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAMessage.h"

@implementation FAMessage

@synthesize ReadFlag;

@synthesize MessageId;

@synthesize MessageType;

@synthesize SenderId;

@synthesize SenderName;

@synthesize MessageTime;

@synthesize MessageTimeString;

@synthesize Context;


- (NSComparisonResult)compareDate:(FAMessage *)element
{
    if(MessageTime >= [element MessageTime])
    {
        return NSOrderedAscending;
    }
    else
    {
        return NSOrderedDescending;
    }
}

@end
