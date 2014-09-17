//
//  FAJSONMapper.h
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAPaginatedDto.h"
#import "RMMapper.h"

// JSON数据序列化类
@interface FAJSONSerialization : NSObject

+ (id) toObject:(NSString*)objClass fromData:(NSData*)data;

+ (NSArray*) toArray:(NSString*)itemClass fromData:(NSArray*)array;

@end
