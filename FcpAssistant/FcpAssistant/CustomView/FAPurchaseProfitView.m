//
//  FAPurchaseProfitView.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-18.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAPurchaseProfitView.h"

@implementation FAPurchaseProfitView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint (context, 75, 10);
    CGContextAddLineToPoint (context, 10, 150);
    CGContextAddLineToPoint (context, 160, 150);
    
    // Closing the path connects the current point to the start of the current path.
    CGContextClosePath(context);
    // And stroke the path
    [[UIColor blackColor] setStroke];
    //CGContextStrokePath(context);
    [[UIColor redColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    //kCGPathFillStroke,kCGPathFill,kCGPathStroke
    
    
}
@end
