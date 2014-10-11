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
#import "FAFormater.h"
@implementation FAPurchaseProfitView

@synthesize dataSource;

- (void)drawRect:(CGRect)rect
{
    @try
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self drawbackGround:context];


//        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
//        CGRect rect = CGRectMake(10.0, 10.0, 80.0,50.0);
//        UIFont *font =[UIFont boldSystemFontOfSize:15.0];
//        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//
//        [@"万恶佛额啊沙发上的麻烦" drawInRect:rect withFont:font];
        

//        [yValueStr drawInRect:rect withFont:font lineBreakMode:NSLineBreakByTruncatingHead alignment:NSTextAlignmentRight];
        
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

//计算画图所需参数
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

//计算最大最小值
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

//计算每点代表值
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
    totalPointCount = pointCount;
}

//填充背景
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

//绘制边框
-(void)drawBorder:(CGContextRef) context
{
    UIColor *borderColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint (context,leftMargin-2, topMargin);
    CGContextAddLineToPoint (context, leftMargin-2, frameHeight - bottomMargin+2);
    CGContextAddLineToPoint (context, frameWidth - rightMargin, frameHeight - bottomMargin+2);
    
    CGContextStrokePath(context);
}

//绘制分隔线
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

//绘制坐标轴坐标点
-(void)drawTickMark:(CGContextRef) context
{
    UIColor *borderColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    CGFloat lengths[] = {6,0};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextSetLineWidth(context, 1.0);
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:8.0];
    
    CGFloat xInterval = viewHeight /3;
    for (int i=0; i<3; i++)
    {
        CGContextMoveToPoint(context,leftMargin-5, topMargin + xInterval*(i+1));
        CGContextAddLineToPoint(context, leftMargin-2, topMargin + xInterval*(i+1));
        CGContextStrokePath(context);
    }
    for (int i=0; i<=3; i++)
    {
        double yValue = minValue + (maxValue - minValue)* i/3;
        NSString *yValueStr = [FAFormater toDecimalStringWithDouble:yValue decimalPlace:0];
        CGRect rect = CGRectMake(0, frameHeight - bottomMargin - xInterval*i-5,leftMargin-5,10);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        [yValueStr drawInRect:rect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentRight];
    }
    
    CGFloat yInterval = viewWidth/4;
    CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
    for (int i=0; i<4; i++)
    {
        CGContextMoveToPoint(context,leftMargin +yInterval *i, topMargin +viewHeight+2);
        CGContextAddLineToPoint (context, leftMargin + yInterval*i,topMargin + viewHeight+5);
        CGContextStrokePath(context);
    }
    for (int i=0;i<4;i++)
    {
        NSInteger index = i*(totalPointCount-1)/4;
        NSLog(@"YIndex:%ld",index);
        if(index < dataSource.count)
        {
            FAStrategyProfitDto *item = dataSource[index];
            NSString *xValueStr =  [FAFormater toShortDateStringWithNSDate:item.SettlementDate];
//            xValueStr = @"2014-09-01";
            CGRect rect = CGRectMake(leftMargin +yInterval *i -20,frameHeight - bottomMargin+5,40,10);
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            [xValueStr drawInRect:rect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
        }
    }
}

//根据数据索引获取X轴坐标
-(CGFloat) getXPosition:(int) index
{
    return leftMargin + xIntervalPoint * index;
}

//根据收益值获取Y轴坐标
-(CGFloat) getYPosition:(double) value
{
    return topMargin + (maxValue - value)/yValuePerPoint;
}

//绘制收益线
-(void) drawProfitLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 1.0);
    
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
