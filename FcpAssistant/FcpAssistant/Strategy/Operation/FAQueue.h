//
//  FAQueue.h
//  FcpAssistant
//
//  Created by admin on 10/9/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAQueue : NSObject
{
    NSMutableArray *array;
    NSLock *liteLock;
}

- (void)enqueue:(id)newObj;
- (id)dequeue;
- (void)clear;

@property (nonatomic, readonly) long count;

@end
