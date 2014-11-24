//
//  Converter.m
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "Converter.h"

@implementation Converter

+(NSString*) asString:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        NSString *string = (NSString*)data;
        return string;
    }
    return nil;
}


+(BOOL) asBool:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumber *o = (NSNumber*)data;
        return [o boolValue];
    }
    
    return false;
}



/// 注意字符串的格式为：yyyy-MM-dd'T'HH:mm:ss
+(NSDate*) asDate:(id)data {
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    if([data isKindOfClass:[NSString class]]) {
        NSString *dateString = data;
        if(dateString.length > 19) {
            dateString = [dateString substringWithRange:NSMakeRange(0, 19)];
            NSDate *date = [Converter asDate:dateString dateFormat: dateFormat];
            return date;
        }
        
        NSDate *date = [Converter asDate:data dateFormat: dateFormat];
        return date;
    }
    return nil;
}

+(NSDate*) asDate:(id)data dateFormat:(NSString*)dateFormat {
    if([data isKindOfClass:[NSString class]]) {
        // NSLog("dateString = \(dateString)")
        NSString *dateString = data;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = dateFormat;
        return [dateFormatter dateFromString:dateString];
    }
    return nil;
}


+(NSString*) asDateString:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

+(NSString*) asDateTimeString:(NSDate*)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

+(NSString*) asDateStringWithFormat:(NSDate*)date format:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

@end
