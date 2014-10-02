//
//  FAStrategyProfitView.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyProfitView.h"

@implementation FAStrategyProfitView

- (instancetype)initWithFrame:(CGRect)frame;          // default initializer
{
    if(self = [super initWithFrame:frame])
    {
        backgroundColor = [UIColor yellowColor];
    }
    return self;
}
@synthesize dataSource;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setBackgroundColor:(UIColor *) backColor
{
    backgroundColor = backColor;
//    [self setNeedsDisplay];
}
-(UIColor *) getBackgroundColor
{
    return backgroundColor;
}



- (void)drawRect:(CGRect)rect
{
    //118,48
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextMoveToPoint (context, 0, 0);
    CGContextAddLineToPoint (context, 118, 0);
    CGContextAddLineToPoint (context, 118, 48);
    CGContextAddLineToPoint (context, 0, 48);
    [[UIColor whiteColor] setFill];
    
    CGContextMoveToPoint (context, 0, 10);
    CGContextAddLineToPoint (context, 10, 30);
    CGContextAddLineToPoint (context, 20, 15);
        CGContextAddLineToPoint (context, 30, 40);
        CGContextAddLineToPoint (context, 40, 25);
        [backgroundColor setStroke];
    CGContextStrokePath(context);
    // Closing the path connects the current point to the start of the current path.
//    CGContextClosePath(context);
    // And stroke the path
    NSLog(@"CellBackColor:%@",self.backgroundColor);

    //CGContextStrokePath(context);
        CGContextMoveToPoint (context, 0, 48);


    
    CGContextAddLineToPoint (context, 0, 10);
    CGContextAddLineToPoint (context, 10, 30);
    CGContextAddLineToPoint (context, 20, 15);
    CGContextAddLineToPoint (context, 30, 40);
    CGContextAddLineToPoint (context, 40, 25);
        CGContextAddLineToPoint (context, 118, 48);
    [[UIColor whiteColor] setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    //kCGPathFillStroke,kCGPathFill,kCGPathStroke
    
    
    
}

@end
