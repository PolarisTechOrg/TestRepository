//
//  UILabelExtension.m
//  OptionLotto
//
//  Created by admin on 14-10-9.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "UILabelExtension.h"
#import <UIKit/UIKit.h>

@implementation UILabel(Text)

-(void) setTextColor:(UIColor*)color range:(NSRange)range {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName value: color range: range];
    
    self.attributedText = text;
}

-(void) setFont:(UIFont*)font range:(NSRange)range {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [text addAttribute:NSFontAttributeName value: font range: range];
    
    self.attributedText = text;
}


-(void) setTextColor:(UIColor*)color afterOccurenceOfString:(NSString*)separator {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:separator];
    if(range.location != NSNotFound) {
        range.location += (separator).length;
        range.length = text.length - range.location;
        [self setTextColor:color range: range];
    }
}


-(void) setTextColor:(UIColor*)color afterOccurenceOfString:(NSString*)separator colorText:(NSString*)colorText {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:separator];
    if(range.location != NSNotFound) {
        range.location += (separator).length;
        
        [self setTextColor:color colorText:colorText startIndex:range.location];
    }
}


-(void) setFont:(UIFont*)font afterOccurenceOfString:(NSString*)separator {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:separator];
    if(range.location != NSNotFound) {
        range.location++;
        range.length = text.length - range.location;
        [self setFont:font range: range];
    }
}


-(void) setTextColor:(UIColor*)color colorText:(NSString*)colorText {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:colorText];
    if(range.location != NSNotFound) {
        [self setTextColor:color range: range];
    }
}


-(void) setTextColor:(UIColor*)color colorText:(NSString*)colorText startIndex:(NSUInteger)startIndex {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange withinRange = NSMakeRange(startIndex, [text length] - startIndex);             //NSRange(location: startIndex, length: text.length - startIndex)
    NSRange range = [text rangeOfString:colorText options: NSCaseInsensitiveSearch range: withinRange];

    if(range.location != NSNotFound) {
        [self setTextColor:color range: range];
    }
}


-(void) setFont:(UIFont*)font fontText:(NSString*)fontText {
    if(self.text == nil) {
        return;
    }
    
    NSString *text = self.text;
    NSRange range = [text rangeOfString:fontText];
    if(range.location != NSNotFound) {
        [self setFont:font range: range];
    }
}

@end
