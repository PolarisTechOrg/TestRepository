//
//  FAHttpUtility.m
//  FcpAssistant2
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "FAHttpUtility.h"
#import "FAJSONSerialization.h"

@implementation FAHttpUtility

//同步发送Get请求。
+ (NSData *)sendRequest:(NSURL *)url error:(NSError *)error
{
    FAHttpHead *defalutHeader = [FAHttpHead defaultInstance];
    return [FAHttpUtility sendRequest:url withHead:defalutHeader httpBody:nil error:error];
}

// 同步发送请求
+ (NSData *)sendRequest:(NSURL *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError *)error
{
    if(url == nil || head == nil)
    {
        return nil;
    }
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:head.TimeOut];
    [urlRequest setHTTPMethod:head.Method];
    
    NSDictionary *bodyDict = [FAJSONSerialization toDictionary:body];
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    
    for(NSString* key in bodyDict.allKeys)
    {
        [bodyString appendString:key];
        [bodyString appendString:@"="];
        [bodyString appendFormat:@"%@",[bodyDict valueForKey:key]];
        [bodyString appendString:@"&"];
    }
    NSUInteger length = [bodyString length];
    [bodyString deleteCharactersInRange:NSMakeRange(length-1, 1)];
    [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *retData;
    NSHTTPURLResponse *response;
    
    retData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    return retData;
}

//    if(bodyDict != nil && [NSJSONSerialization isValidJSONObject:bodyDict])
//    {
//        NSData *postData = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:&error];

//        NSNumber *length = [NSNumber numberWithLong:[postData length]];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [length intValue]];
//
//        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Tppe"];
//        [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [urlRequest setHTTPBody:postData];
//    }
@end
