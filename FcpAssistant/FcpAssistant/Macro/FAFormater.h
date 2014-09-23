//
//  FAFormater.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFormater : NSObject
{
    
}

//千分位格式化
+(id) decimalFormater;

//日期yyyy-MM-dd 格式化
+(id) shortDateFormater;

//日期yyyy-MM-dd HH:mm:ss 格式化
+(id) longTimeFormater;

//日期yyyy-MM-dd HH:mm:ss 格式化
+(id) shortTimeFormater;


//格式化为千分位字符串
+(NSString *) toDecimalStringWithInt:(int) value;

//格式化为指定小数位数千分位字符串
+(NSString *) toDecimalStringWithDouble:(double) value decimalPlace:(int) decimalPlace;

//格式化为yyyy-MM-dd字符串
+(NSString *) toShortDateStringWithNSDate:(NSDate *) value;

//格式化为yyyy-MM-dd HH:mm:ss字符串
+(NSString *) toLongTimeStringWithNSDate:(NSDate *) value;

//格式化为HH:mm:ss字符串
+(NSString *) toShortTimeStringWithNSDate:(NSDate *) value;
@end
