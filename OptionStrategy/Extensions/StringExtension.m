//
//  StringExtension.m
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "StringExtension.h"

@implementation NSString(Number)

-(BOOL) isNumeric {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    if([scanner scanFloat:nil]) {
        return [scanner isAtEnd];
    }
    return false;
}

@end
