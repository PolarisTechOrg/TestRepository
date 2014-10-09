//
//  FAQueue.m
//  FcpAssistant
//
//  Created by admin on 10/9/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAQueue.h"

@implementation FAQueue

@synthesize count;

- (id)init
{
    if(self = [super init])
    {
        array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}

- (void)enqueue:(id)newObj
{
    [array addObject:newObj];
    count = array.count;
}

- (id)dequeue
{
    id obj = nil;
    if(array.count == 0)
    {
        return obj;
    }
    
    obj = [array objectAtIndex:0];
    [array removeObjectAtIndex:0];
    count = array.count;
    
    return obj;
}

- (void)clear
{
    [array removeAllObjects];
    count = 0;
}

@end
