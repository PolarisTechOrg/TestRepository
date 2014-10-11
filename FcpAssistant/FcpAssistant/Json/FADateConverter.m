//
//  FADateConverter.m
//  FcpAssistant
//
//  Created by admin on 10/11/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FADateConverter.h"

@implementation FADateConverter

+ (NSDate *)asDate:(id)data dateFormat:(NSString *)dateFormat
{
    if([data isKindOfClass:[NSString class]])
    {
        NSString *dateString = data;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = dateFormat;
        
        return [dateFormatter dateFromString:dateString];
    }
    else
    {
        return nil;
    }
}

@end
