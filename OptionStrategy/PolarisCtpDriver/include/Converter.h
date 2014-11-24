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
+(NSDate*) asDate:(id)data;
+(NSDate*) asDate:(id)data dateFormat:(NSString*)dateFormat;
+(NSString*) asDateString:(NSDate*)date;
+(NSString*) asDateTimeString:(NSDate*)date;
+(NSString*) asDateStringWithFormat:(NSDate*)date format:(NSString*)format;

@end
