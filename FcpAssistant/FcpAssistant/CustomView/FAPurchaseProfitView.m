//
//  FAPurchaseProfitView.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-18.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAPurchaseProfitView.h"
#import "FAStrategyProfitDto.h"
#import "FAUtility.h"

@implementation FAPurchaseProfitView

@synthesize dataSource;

- (void)drawRect:(CGRect)rect
{
    @try
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self calculatePara];
        [self drawbackGround:context];
        [self drawBorder:context];
        [self drawSpiterLine:context];
        [self drawTickMark:context];
        if(self.dataSource !=nil && self.dataSource.count >0)
        {
            [self drawProfitLine:context];
        }
        
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
    }
}

-(void)calculatePara
{
    frameHeight = self.bounds.size.height;
    frameWidth = self.bounds.size.width;

    leftMargin = 40.0;
    rightMargin = 15.0;
    topMargin = 10.0;
    bottomMargin = 25.0;
    
    viewHeight = frameHeight - topMargin - bottomMargin;
    viewWidth = frameWidth - leftMargin - rightMargin;
    
    profitLineColor = [UIColor redColor];
    
    if(dataSource != nil && dataSource.count >0)
    {
        [self calculateMinAndMaxValue];
        [self calculatePointValue];
    }
}

-(void)calculateMinAndMaxValue
{
    maxValue = ((FAStrategyProfitDto *)dataSource[0]).Profit;
    minValue = ((FAStrategyProfitDto *)dataSource[0]).Profit;
    for(int i=0;i<dataSource.count;i++)
    {
        FAStrategyProfitDto *item = dataSource[i];
        if(maxValue < item.Profit)
        {
            maxValue = item.Profit;
        }
        if(minValue > item.Profit)
        {
            minValue = item.Profit;
        }
    }
}
-(void)calculatePointValue
{
    NSInteger pointCount = self.dataSource.count;
    if(pointCount <13)
    {
        pointCount = 13;
    }
    
    if ((pointCount-1)%4 !=0)
    {
        pointCount = pointCount + 4 -(pointCount-1)%4;
    }
    
    xIntervalPoint = viewWidth/(pointCount-1);
    
    yValuePerPoint = (maxValue - minValue)/viewHeight;
}

-(void)drawbackGround:(CGContextRef) context
{
    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextMoveToPoint (context,  0, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width,self.bounds.size.height);
    CGContextAddLineToPoint (context, 0, self.bounds.size.height);
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)drawBorder:(CGContextRef) context
{
    UIColor *borderColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint (context,leftMargin, topMargin);
    CGContextAddLineToPoint (context, leftMargin, frameHeight - bottomMargin);
    CGContextAddLineToPoint (context, frameWidth - rightMargin, frameHeight - bottomMargin);
    
    CGContextStrokePath(context);
}

-(void)drawSpiterLine:(CGContextRef) context
{
    UIColor *borderColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    CGContextSetLineWidth(context, 1.5);
    
    CGFloat lengths[] = {6,3};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextSetLineWidth(context, 0.5);
    
    CGFloat xInterval = viewHeight /3;
    for (int i=0; i<3; i++)
    {
        CGContextMoveToPoint (context,leftMargin, topMargin + xInterval*i);
        CGContextAddLineToPoint (context, leftMargin + viewWidth, topMargin + xInterval*i);
        CGContextStrokePath(context);
    }
    
    CGFloat yInterval = viewWidth/4;
    for (int i=0; i<4; i++)
    {
        CGContextMoveToPoint(context,leftMargin +yInterval *(i+1), topMargin);
        CGContextAddLineToPoint (context, leftMargin + yInterval*(i+1),topMargin + viewHeight);
        CGContextStrokePath(context);
    }
}

-(void)drawTickMark:(CGContextRef) context
{
    UIColor *borderColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    
    CGFloat xInterval = viewHeight /3;
    for (int i=0; i<3; i++)
    {
        CGContextMoveToPoint(context,leftMargin-5, topMargin + xInterval*(i+1));
        CGContextAddLineToPoint(context, leftMargin, topMargin + xInterval*(i+1));
        CGContextStrokePath(context);
    }
    
    CGFloat yInterval = viewWidth/4;
    for (int i=0; i<4; i++)
    {
        CGContextMoveToPoint(context,leftMargin +yInterval *i, topMargin +viewHeight);
        CGContextAddLineToPoint (context, leftMargin + yInterval*i,topMargin + viewHeight+5);
        CGContextStrokePath(context);
    }
}

-(CGFloat) getXPosition:(int) index
{
    return leftMargin + xIntervalPoint * index;
}
-(CGFloat) getYPosition:(double) value
{
    return topMargin + (maxValue - value)/yValuePerPoint;
}

-(void) drawProfitLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetLineCap(context,kCGLineCapSquare);


    CGFloat xStart = [self getXPosition:0];
    CGFloat yStart =[self getYPosition: ((FAStrategyProfitDto *)dataSource[0]).Profit];
    CGContextMoveToPoint (context,xStart,yStart);
    for (int i=1;i<dataSource.count;i++)
    {
        FAStrategyProfitDto *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Profit];
        
        CGContextAddLineToPoint (context,xPos,yPos);
    }
    [profitLineColor setStroke];
    CGContextStrokePath(context);
}
@end
