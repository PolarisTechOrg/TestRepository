//
//  FAErrorExtractor.m
//  FcpAssistant
//
//  Created by admin on 9/28/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAErrorExtractor.h"

@implementation FAErrorExtractor

+ (void)fromResponse: (NSURLResponse *) response data:(NSData *)data toError:(NSError **)error;
{
    if(response == nil)
    {
        return;
    }
    
    long statusCode = 200;
    NSString *content = nil;
    NSDictionary *userInfo = nil;
    
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        statusCode = [httpResponse statusCode];
    }
    if(data != nil)
    {
        content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if(statusCode < 200 || statusCode > 206)
    {
        userInfo = [NSDictionary dictionaryWithObject:content forKey:NSLocalizedDescriptionKey];
        
        if(error != nil)
        {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:statusCode userInfo:userInfo];
        }
    }
}

@end
