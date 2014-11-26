//
//  Converter.h
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject

+(NSString*) asString:(id)data ;
+(BOOL) asBool:(id)data ;
///将日期字符串和时间字符串转为日期对象，按照指定的格式。
+(NSDate*) asDate:(NSString*)dateString timeString:(NSString*)timeString fromat:(NSString*)format;
+(NSDate*) asDate:(id)data;
+(NSDate*) asDate:(id)data dateFormat:(NSString*)dateFormat;
+(NSString*) asDateString:(NSDate*)date;
+(NSString*) asDateTimeString:(NSDate*)date;
+(NSString*) asDateStringWithFormat:(NSDate*)date format:(NSString*)format;

@end
