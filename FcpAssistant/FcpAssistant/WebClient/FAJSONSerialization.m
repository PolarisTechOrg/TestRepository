//
//  FAJSONMapper.m
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <objc/runtime.h>
#import "FAJSONSerialization.h"
#import "RMMapper.h"

// JSON数据序列化类
@implementation FAJSONSerialization


+ (id) toObject:(NSString*)objClass fromData:(NSData*)data{
    
    NSError *error = nil;
    Class objType = NSClassFromString(objClass);
    id returnObject = [[objType alloc] init];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    returnObject = [RMMapper objectWithClass:objType fromDictionary:jsonDict];
    
    return returnObject;
}


+ (NSArray*) toArray:(NSString*)itemClass fromData:(NSArray*)array{
    
    NSArray *retArray = [[NSArray alloc] init];
    Class itemType = NSClassFromString(itemClass);
    
    retArray = [RMMapper arrayOfClass:itemType fromArrayOfDictionary:array];
    
    return retArray;
}

@end
