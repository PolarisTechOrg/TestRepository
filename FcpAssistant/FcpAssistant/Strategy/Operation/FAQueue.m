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
        
        liteLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)enqueue:(id)newObj
{
    [liteLock lock];
    
    [array addObject:newObj];
    count = array.count;
    
    [liteLock unlock];
}

- (id)dequeue
{
    [liteLock lock];
    
    id obj = nil;
    if(array.count == 0)
    {
        return obj;
    }
    
    obj = [array objectAtIndex:0];
    [array removeObjectAtIndex:0];
    count = array.count;
    
    [liteLock unlock];
    
    return obj;
}

- (void)clear
{
    [liteLock lock];
    
    [array removeAllObjects];
    count = 0;
    
    [liteLock unlock];
}

- (id)peek:(int)index
{
    [liteLock lock];
    
    if(array.count == 0 || index < 0)
    {
        return nil;
    }
    id retObj =[array objectAtIndex:index];
    
    [liteLock unlock];
    
    return retObj;
}

@end
