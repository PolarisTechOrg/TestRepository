//
//  FAJSONMapper.m
//  FcpAssistant
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "FAJSONSerialization.h"

@implementation FAJSONSerialization

+ (id) toObject:(Class)objType fromData:(NSData *)data
{
    NSError *error = nil;

    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if([jsonObject isKindOfClass:[NSDictionary class]])
    {
        id retObject = [[objType alloc] init];
        NSDictionary *jsonDict = (NSDictionary *)jsonObject;
        return [Jastor initObject:retObject fromDictionary:jsonDict];
    }
    else
    {
        return jsonObject;
    }
}


+ (NSArray*) toArray:(Class)objType fromData:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if((NSNull *)jsonDict == [NSNull null])
    {
        return [NSArray array];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:jsonDict.count];
    for(id obj in jsonDict)
    {
        if([obj isKindOfClass:[NSDictionary class]])
        {
            id retObject = [[objType alloc] init];
            [array addObject:[Jastor initObject:retObject fromDictionary:obj]];
        }
        else
        {
            [array addObject:obj];
        }
    }
    
    return [NSArray arrayWithArray:array];
}

+ (NSDictionary *) toDictionary:(id)obj
{
    if(obj == nil)
    {
        return nil;
    }
    return [Jastor toDictionary:obj];
}

@end
