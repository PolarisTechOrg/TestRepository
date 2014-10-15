//
//  FAStrategyProfitView.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyProfitView.h"
#import "FADrawedReturnViewModel.h"

@implementation FAStrategyProfitView

- (instancetype)initWithFrame:(CGRect)frame;          // default initializer
{
    if(self = [super initWithFrame:frame])
    {
    }
    return self;
}

@synthesize dataSource;
@synthesize backgroundColor;
@synthesize profitLineColor;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)setBackgroundColor:(UIColor *) backColor
//{
//    backgroundColor = backColor;
////    [self setNeedsDisplay];
//}
//-(UIColor *) getBackgroundColor
//{
//    return backgroundColor;
//}



- (void)drawRect:(CGRect)rect
{
    [self calculatePara];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawbackGround:context];
    if(dataSource !=nil && dataSource.count >1)
    {
        [self drawWhiteFillRange:context];
        [self drawProfitCavLine:context];
    }
}

-(void) calculatePara
{
    if(dataSource == nil || dataSource.count <=0)
    {
        return;
    }
    
    maxValue = ((FADrawedReturnViewModel *)dataSource[0]).Data;
    minValue = ((FADrawedReturnViewModel *)dataSource[0]).Data;
    for(int i=0;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        if(maxValue < item.Data)
        {
            maxValue = item.Data;
        }
        if(minValue > item.Data)
        {
            minValue = item.Data;
        }
    }
    
    xInterval = self.bounds.size.width /(dataSource.count-1);
    yPointValue = (maxValue - minValue)/self.bounds.size.height;
}

-(CGFloat) getXPosition:(int) index
{
    return xInterval * index;
}
-(CGFloat) getYPosition:(double) value
{
    return (maxValue - value)/yPointValue;
}

-(void)drawbackGround:(CGContextRef) context
{
    CGContextSetStrokeColorWithColor(context,backgroundColor.CGColor);
    CGContextMoveToPoint (context,  0, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width, 0);
    CGContextAddLineToPoint (context, self.bounds.size.width,self.bounds.size.height);
    CGContextAddLineToPoint (context, 0, self.bounds.size.height);
    [self.backgroundColor setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)drawProfitLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 2.0);
    CGFloat xStart = [self getXPosition:0];
    CGFloat yStart =[self getYPosition: ((FADrawedReturnViewModel *)dataSource[0]).Data];
    CGContextMoveToPoint (context,xStart,yStart);
    for (int i=1;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Data];
        
        CGContextAddLineToPoint (context,xPos,yPos);
    }
    [self.profitLineColor setStroke];
    CGContextStrokePath(context);
}

-(void)drawProfitCavLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 2.0);
    CGFloat xStart = [self getXPosition:0];
    CGFloat yStart =[self getYPosition: ((FADrawedReturnViewModel *)dataSource[0]).Data];
    CGContextMoveToPoint (context,xStart,yStart);
    for (int i=1;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Data];
        
        CGContextAddLineToPoint (context,xPos,yPos);
    }
    [self.profitLineColor setStroke];
    CGContextStrokePath(context);
}



-(void)drawWhiteFillRange:(CGContextRef) context
{
    CGContextMoveToPoint (context, 0, self.bounds.size.height);
    for (int i=0;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Data];
        
//        CGContextAddCurveToPoint(context, xPos-10, yPos-10, xPos+10, yPos+10, xPos, yPos);
        CGContextAddLineToPoint (context,xPos,yPos);
    }
    CGContextAddLineToPoint (context, self.bounds.size.width, self.bounds.size.height);
    
    [[UIColor whiteColor] setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
