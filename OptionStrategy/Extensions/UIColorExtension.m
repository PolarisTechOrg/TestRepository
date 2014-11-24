//
//  UIColorExtension.m
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "UIColorExtension.h"

@implementation UIColor(RGB)

+(UIColor*) fromRGB:(uint)rgbValue alpha:(double)alpha {
    UIColor *color = [UIColor colorWithRed:(((rgbValue & 0xFF0000) >> 16) / 255.0) green:(((rgbValue & 0x00FF00) >> 8) / 255.0) blue:((rgbValue & 0x0000FF) / 255.0) alpha:alpha];
    return color;
    
//    return UIColor(
//                   red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//                   green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//                   blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//                   alpha: CGFloat(alpha)
//                   )
    ////alpha: CGFloat(1.0)
}


+(UIColor*) fromRGBString:(NSString*)rgb alpha:(double)alpha {
    CGFloat red   = 0.0;
    CGFloat green = 0.0;
    CGFloat blue  = 0.0;
    //var alpha: CGFloat = 1.0
    
    if( [rgb hasPrefix:@"#"]) {
        NSString* hex = [rgb substringFromIndex:1];
        
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        
        unsigned long long hexValue = 0;
        if([scanner scanHexLongLong:&hexValue]) {
            if ([hex length] == 6) {
                red   = ((hexValue & 0xFF0000) >> 16) / 255.0;
                green = ((hexValue & 0x00FF00) >> 8)  / 255.0;
                blue  = (hexValue & 0x0000FF) / 255.0;
            } else {
                NSLog(@"invalid rgb string, length should be 7");
            }
        } else {
            NSLog(@"scan hex error");
        }
    } else {
        NSLog(@"invalid rgb string, missing '#' as prefix");
    }
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}


/*
 else if hex.length() == 8 {
 red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
 green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
 blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
 alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
 }
 */

+(UIColor*) fromRGB:(int)red green:(int)green blue:(int)blue alpha:(double)alpha {
    UIColor *color = [UIColor colorWithRed:((red) / 255.0) green: ((green) / 255.0) blue: ((blue) / 255.0) alpha: alpha];
    return color;
    ////alpha: CGFloat(1.0)
}

@end
