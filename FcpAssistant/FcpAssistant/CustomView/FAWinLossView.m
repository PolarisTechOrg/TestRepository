//
//  FAWinLossView.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAWinLossView.h"
#import "FAUtility.h"
@implementation FAWinLossView

- (void)drawRect:(CGRect)rect
{
    @try
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
//        [self calculatePara];
        [self drawbackGround:context];
//        [self drawBorder:context];
//        [self drawSpiterLine:context];
//        [self drawTickMark:context];
//        if(self.dataSource !=nil && self.dataSource.count >0)
//        {
//            [self drawProfitLine:context];
//        }
        
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
    }
}

//填充背景
-(void)drawbackGround:(CGContextRef) context
{
    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
    CGContextMoveToPoint (context,  0, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width,self.bounds.size.height);
    CGContextAddLineToPoint (context, 0, self.bounds.size.height);
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
