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
@synthesize headeDic;

+(instancetype) defaultInstance
{
    return [[FAHttpHead alloc] initDefault];
}

- (FAHttpHead *)initDefault
{
    self.TimeOut = 30.0f;
    self.Method = @"GET";
    self.headeDic = nil;
    return self;
}
@end
