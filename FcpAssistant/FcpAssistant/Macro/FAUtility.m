//
//  FAEncryptUtility.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAUtility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation FAUtility

//SHA加密算法
+ (NSString *)sha1:(NSString *)source
{
    const char *cstr = [source cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:source.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+(void) showAlterView:(NSString *) errorMessage
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

+(void) showAlterViewWithException:(NSException *) exception
{
    NSString *errorMessage = [exception.userInfo valueForKey:NSLocalizedDescriptionKey];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}
@end
