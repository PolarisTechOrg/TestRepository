//
//  FAJSONMapper.h
//  FcpAssistant
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Jastor.h"

@interface FAJSONSerialization : NSObject

+ (id) toObject:(NSString*)objClass fromData:(NSData *)data;
+ (NSArray *) toArray:(NSString *)objClass fromData:(NSData *)data;
+ (NSDictionary *) toDictionary:(id)obj;

//+ (id) toPageObject:(NSString*)objClass fromData:(NSObject*)data;
//+ (id) toItemObject:(NSString*)objClass fromData:(NSDictionary*)data;
@end