//
//  FAMessage.m
//  FcpAssistant
//
//  Created by admin on 10/2/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAMessageDetail.h"

@implementation FAMessageDetail

@synthesize SenderId;

@synthesize MessageType;

@synthesize Date;

@synthesize DateString;

@synthesize DetailList;


- (NSComparisonResult)compareDate:(FAMessageDetail *)element
{
    if(Date >= [element Date])
    {
        return NSOrderedAscending;
    }
    else
    {
        return NSOrderedDescending;
    }
}

@end
