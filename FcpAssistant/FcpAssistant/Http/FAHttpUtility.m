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

// 同步发送请求
+ (NSData *)sendRequest:(NSString *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError *)error
{
    if(url == nil || head == nil)
    {
        return nil;
    }
    
    NSURL *realUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:realUrl];
    [urlRequest setTimeoutInterval:head.TimeOut];
    [urlRequest setHTTPMethod:head.Method];
    
    NSDictionary *bodyDict = [FAJSONSerialization toDictionary:body];
    
    if(bodyDict != nil && [NSJSONSerialization isValidJSONObject:bodyDict])
    {
        NSData *postData = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:&error];
        
        NSNumber *length = [NSNumber numberWithLong:[postData length]];
        NSString *postLength = [NSString stringWithFormat:@"%d", [length intValue]];
        
        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Tppe"];
        [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:postData];
    }
    
    NSData *retData;
    NSHTTPURLResponse *response;
    
    retData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    return retData;
}

@end
