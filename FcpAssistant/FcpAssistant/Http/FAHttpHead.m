//
//  FAHttpHead.m
//  FcpAssistant
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "FAHttpHead.h"

@implementation FAHttpHead

@synthesize TimeOut;
@synthesize Method;

- (FAHttpHead *)initDefault
{
    self.TimeOut = 30.0f;
    self.Method = @"GET";
    
    return self;
}
@end
