//
//  FAFormater.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAFormater.h"
static NSNumberFormatter *faDecimalFormater;
static NSDateFormatter *fashortDateFormater;
static NSDateFormatter *faLongTimeFormater;
static NSDateFormatter *faShortTimeFormater;

@implementation FAFormater

//千分位格式化
+(id) decimalFormater
{
    if(faDecimalFormater == nil)
    {

        faDecimalFormater = [[NSNumberFormatter alloc] init];
        faDecimalFormater.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return faDecimalFormater;
}

//日期yyyy-MM-dd 格式化
+(id) shortDateFormater
{
    if(fashortDateFormater == nil)
    {
        fashortDateFormater = [[NSDateFormatter alloc] init];
        [fashortDateFormater setDateFormat:@"yyyy-MM-dd"];
    }
    return fashortDateFormater;
}


//日期yyyy-MM-dd HH:mm:ss 格式化
+(id) longTimeFormater
{
    if(faLongTimeFormater == nil)
    {
        faLongTimeFormater = [[NSDateFormatter alloc] init];
        [faLongTimeFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return faLongTimeFormater;
}

//日期yyyy-MM-dd HH:mm:ss 格式化
+(id) shortTimeFormater
{
    if(faShortTimeFormater == nil)
    {
        faShortTimeFormater = [[NSDateFormatter alloc] init];
        [faShortTimeFormater setDateFormat:@"HH:mm:ss"];
    }
    return faShortTimeFormater;
}




//格式化为千分位字符串
+(NSString *) toDecimalStringWithInt:(int) value
{
    return [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithInt:value]];
}


//格式化为指定小数位数千分位字符串
+(NSString *) toDecimalStringWithDouble:(double) value decimalPlace:(int) decimalPlace
{
    return [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithInt:value]];
}

//格式化为yyyy-MM-dd字符串
+(NSString *) toShortDateStringWithNSDate:(NSDate *) value
{
    return [[FAFormater shortDateFormater] stringFromDate:value];
}

//格式化为yyyy-MM-dd HH:mm:ss字符串
+(NSString *) toLongTimeStringWithNSDate:(NSDate *) value
{
    return [[FAFormater longTimeFormater] stringFromDate:value];
}

//格式化为HH:mm:ss字符串
+(NSString *) toShortTimeStringWithNSDate:(NSDate *) value
{
    return [[FAFormater shortTimeFormater] stringFromDate:value];
}

@end
