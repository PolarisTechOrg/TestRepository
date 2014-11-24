//
//  UIColorExtension.h
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(RGB)

+(UIColor*) fromRGB:(uint)rgbValue alpha:(double)alpha;
+(UIColor*) fromRGBString:(NSString*)rgb alpha:(double)alpha ;
+(UIColor*) fromRGB:(int)red green:(int)green blue:(int)blue alpha:(double)alpha;

@end
