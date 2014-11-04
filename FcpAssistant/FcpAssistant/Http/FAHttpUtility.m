//
//  FAHttpUtility.m
//  FcpAssistant2
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "FAHttpUtility.h"
#import "FAJSONSerialization.h"
#import "FAErrorExtractor.h"

@implementation FAHttpUtility

// url encode
+ (NSString *)urlEncoding:(id)source
{
    NSString *sourceString = [NSString stringWithFormat:@"%@", source];
    NSString *encodeSourceString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)sourceString, NULL, CFSTR("!*'();:@&=+$,/?%#[]") , kCFStringEncodingUTF8));
    
    return encodeSourceString;
}

//同步发送Get请求。
+ (NSData *)sendRequest:(NSURL *)url error:(NSError **)error
{
    FAHttpHead *defalutHeader = [FAHttpHead defaultInstance];
    return [FAHttpUtility sendRequest:url withHead:defalutHeader httpBody:nil error:error];
}

+(NSString *)JSONStringify:(id) jsonObje
{
    NSError *e;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObje options:0 error:&e];
    if(e != nil)
    {
        return @"";
    }
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return result;
}
// 同步发送请求
+ (NSData *)sendRequest:(NSURL *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError **)error
{
    if(url == nil || head == nil)
    {
        return nil;
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:head.TimeOut];
    [urlRequest setHTTPMethod:head.Method];
    if(head.ContentType.length >0)
    {
    [urlRequest setValue:head.ContentType forHTTPHeaderField:@"Content-type"];
    }

    if(head.headeDic != nil)
    {
        for (NSString *key in head.headeDic)
        {
            [urlRequest addValue:head.headeDic[key] forHTTPHeaderField:key];
        }
    }
    
    if(body != nil)
    {
//        NSMutableString *bodyString = [[NSMutableString alloc] init];
        
        NSDictionary *bodyDict = [FAJSONSerialization toDictionary:body];
//        
//        for(NSString* key in bodyDict.allKeys)
//        {
//            [bodyString appendString:key];
//            [bodyString appendString:@"="];
//            [bodyString appendFormat:@"%@", [self urlEncoding:[bodyDict valueForKey:key]]];
//            [bodyString appendString:@"&"];
//        }
        NSString *bodyString = [FAHttpUtility JSONStringify:bodyDict];
//        NSUInteger length = [bodyString length];
//        if(length > 0)
//        {
//            [bodyString deleteCharactersInRange:NSMakeRange(length-1, 1)];
//        }
//        bodyString =@"{\"OnlineStatus\":1,\"PageSize\":10,\"PageIndex\":1,\"SearchVarieties\":[\"IF\"],\"RacerType\":1,\"SearchPriceParten\":[]}";
        [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSData *retData;
    NSURLResponse *response;
    
    retData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:error];
    
    [FAErrorExtractor fromResponse:response data:retData toError:error];
    
    return retData;
}

+ (NSData *)sendRequestForReponse:(NSURL *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError **)error replyResponse:(NSURLResponse **)replyResponse
{
    if(url == nil || head == nil)
    {
        return nil;
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:head.TimeOut];
    [urlRequest setHTTPMethod:head.Method];
    
    if(body != nil)
    {
        NSMutableString *bodyString = [[NSMutableString alloc] init];
        
        if ([body isKindOfClass:[NSNumber class]] || [body isKindOfClass:[NSString class]])
        {
            NSString *bodyString = [NSString stringWithFormat:@"%@", body];
            NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding];
            [urlRequest setHTTPBody:postData];
        }
        else
        {
            NSDictionary *bodyDict = [FAJSONSerialization toDictionary:body];
            
            for(NSString* key in bodyDict.allKeys)
            {
                [bodyString appendString:key];
                [bodyString appendString:@"="];
                [bodyString appendFormat:@"%@", [self urlEncoding:[bodyDict valueForKey:key]]];
                [bodyString appendString:@"&"];
            }
            NSUInteger length = [bodyString length];
            if(length > 0)
            {
                [bodyString deleteCharactersInRange:NSMakeRange(length-1, 1)];
            }
            
            [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    NSData *retData;
    NSURLResponse *response;
    
    retData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:error];
    
    [FAErrorExtractor fromResponse:response data:retData toError:error];
    *replyResponse = response;
    return retData;

}
@end
