//
//  UILabelExtension.h
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel(Text)

-(void) setTextColor:(UIColor*)color range:(NSRange)range;
-(void) setFont:(UIFont*)font range:(NSRange)range;
-(void) setTextColor:(UIColor*)color afterOccurenceOfString:(NSString*)separator;
-(void) setTextColor:(UIColor*)color afterOccurenceOfString:(NSString*)separator colorText:(NSString*)colorText;
-(void) setFont:(UIFont*)font afterOccurenceOfString:(NSString*)separator;
-(void) setTextColor:(UIColor*)color colorText:(NSString*)colorText;
-(void) setTextColor:(UIColor*)color colorText:(NSString*)colorText startIndex:(NSUInteger)startIndex ;
-(void) setFont:(UIFont*)font fontText:(NSString*)fontText;

@end
