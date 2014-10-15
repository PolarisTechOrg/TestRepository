//
//  FAStrategyProfitView.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyProfitView.h"
#import "FADrawedReturnViewModel.h"
#import "FAUtility.h"

@implementation FAStrategyProfitView

- (instancetype)initWithFrame:(CGRect)frame;          // default initializer
{
    if(self = [super initWithFrame:frame])
    {
        fillView = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:fillView];
        
        shapeView = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:shapeView];
    }
   
    return self;
}


@synthesize dataSource;
@synthesize backgroundColor;
@synthesize profitLineColor;

- (void)drawRect:(CGRect)rect
{
    @try
    {
        [self calculatePara];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [self drawbackGround:context];
        if(dataSource !=nil && dataSource.count >1)
        {
//            [self drawWhiteFillRange:context];
            [self drawCurvedLineBetweenPoints:context];
//            [self drawProfitLine:context];
//            [self drawProfitCavLine:context];
        }
        else
        {
//            fillView.path = [fillPath CGPath];
            
            fillView.strokeColor = [UIColor whiteColor].CGColor;
            fillView.fillColor = [UIColor whiteColor].CGColor;
            fillView.lineWidth = 0.1;
            [fillView setLineCap:kCALineCapRound];
            
//            shapeView.path = [path CGPath];
            
            shapeView.strokeColor = [UIColor whiteColor].CGColor;
            shapeView.fillColor = [UIColor clearColor].CGColor;
            shapeView.lineWidth = 2;
            [shapeView setLineCap:kCALineCapRound];
            
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

-(void) calculatePara
{
    frameHeight = self.bounds.size.height;
    frameWidth = self.bounds.size.width;
    
    leftMargin = 2.0;
    rightMargin = 2.0;
    topMargin = 2.0;
    bottomMargin = 2.0;
    
    viewHeight = frameHeight - topMargin - bottomMargin;
    viewWidth = frameWidth - leftMargin - rightMargin;
    
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
    
    xInterval = viewWidth /(dataSource.count-1);
    yPointValue = (maxValue - minValue)/viewHeight;
}

-(CGFloat) getXPosition:(int) index
{
    return leftMargin + xInterval * index;
}
-(CGFloat) getYPosition:(double) value
{
    return (maxValue - value)/yPointValue;
}

-(void)drawbackGround:(CGContextRef) context
{
//    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
//    CGContextMoveToPoint (context,  0, 0);
//    CGContextAddLineToPoint (context, self.bounds.size.width, 0);
//    CGContextAddLineToPoint (context, self.bounds.size.width,self.bounds.size.height);
//    CGContextAddLineToPoint (context, 0, self.bounds.size.height);
//    [[UIColor whiteColor] setFill];
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, CGRectMake(0, 0, frameWidth,frameHeight));

}

-(void)drawProfitLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 1.0);
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
    [[UIColor yellowColor] setStroke];
//    [self.profitLineColor setStroke];
    CGContextStrokePath(context);
}

-(void)drawProfitCavLine:(CGContextRef) context
{
    CGContextSetLineWidth(context, 2.0);
    CGFloat xStart = [self getXPosition:0];
    CGFloat yStart =[self getYPosition: ((FADrawedReturnViewModel *)dataSource[0]).Data];
    CGContextMoveToPoint (context,xStart,yStart);
    
    CGPoint curPoint = CGPointMake(xStart, yStart);
    for (int i=1;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Data];
        
        CGFloat ctrlX;
        CGFloat ctrlY;
        if(yPos > xPos)
        {
            ctrlX = curPoint.x;
            ctrlY = yPos;
        }
        else
        {
            ctrlX = xPos;
            ctrlY = curPoint.y;
        }
        
        curPoint = CGPointMake(xPos, yPos);
            // 添加二次曲线路径
            CGContextAddQuadCurveToPoint(context,ctrlX , ctrlY , xPos, yPos);
    }
    [self.profitLineColor setStroke];
    CGContextStrokePath(context);
}

-(NSMutableArray *)createPoints
{
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    for(int i=0;i<dataSource.count;i++)
    {
        FADrawedReturnViewModel *item = dataSource[i];
        CGFloat xPos = [self getXPosition:i];
        CGFloat yPos = [self getYPosition:item.Data];
        
        NSValue *pointValue = [[NSValue alloc] init];
        pointValue = [NSValue valueWithCGPoint:CGPointMake(xPos, yPos)];
        [pointArray addObject:pointValue];
    }
    return pointArray;
}

- (CGPoint)pointAtIndex:(NSUInteger)index ofArray:(NSArray *)array
{
    NSValue *value = [array objectAtIndex:index];
    
    return [value CGPointValue];
}

- (void)drawCurvedLineBetweenPoints:(CGContextRef) context
{
    NSArray *points =[self createPoints];
    float granularity = 200;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
    
    [path moveToPoint:[self pointAtIndex:0 ofArray:points]];
    
    [fillPath moveToPoint:CGPointMake(leftMargin, frameHeight)];
    
    [fillPath addLineToPoint:[self pointAtIndex:0 ofArray:points]];
    for (int index = 1; index < points.count - 2 ; index++)
    {
        CGPoint point0 = [self pointAtIndex:index - 1 ofArray:points];
        CGPoint point1 = [self pointAtIndex:index ofArray:points];
        CGPoint point2 = [self pointAtIndex:index + 1 ofArray:points];
        CGPoint point3 = [self pointAtIndex:index + 2 ofArray:points];
        
        for (int i = 1; i < granularity ; i++)
        {
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi;
            pi.x = 0.5 * (2*point1.x+(point2.x-point0.x)*t + (2*point0.x-5*point1.x+4*point2.x-point3.x)*tt + (3*point1.x-point0.x-3*point2.x+point3.x)*ttt);
            pi.y = 0.5 * (2*point1.y+(point2.y-point0.y)*t + (2*point0.y-5*point1.y+4*point2.y-point3.y)*tt + (3*point1.y-point0.y-3*point2.y+point3.y)*ttt);
            
            if (pi.y > self.bounds.size.height)
            {
                pi.y = self.bounds.size.height;
            }
            else if (pi.y < 0)
            {
                pi.y = 0;
            }
            
            if (pi.x > point0.x)
            {
                [path addLineToPoint:pi];
                [fillPath addLineToPoint:pi];
            }
        }
        
        [path addLineToPoint:point2];
        [fillPath addLineToPoint:point2];
    }
    
    [path addLineToPoint:[self pointAtIndex:[points count] - 1 ofArray:points]];
    [fillPath addLineToPoint:[self pointAtIndex:[points count] - 1 ofArray:points]];
    
    [fillPath addLineToPoint:CGPointMake(leftMargin +viewWidth, frameHeight)];
    
    //    CGContextBeginPath(context);
    //    CGContextStrokePath(context);
    //    CAShapeLayer *shapeView = [[CAShapeLayer alloc] init];
    //
    fillView.path = [fillPath CGPath];
    
    fillView.strokeColor = profitLineColor.CGColor;
    fillView.fillColor = backgroundColor.CGColor;
    fillView.lineWidth = 0.1;
    [fillView setLineCap:kCALineCapRound];
    
    shapeView.path = [path CGPath];
    
    shapeView.strokeColor = profitLineColor.CGColor;
    shapeView.fillColor = [UIColor clearColor].CGColor;
    shapeView.lineWidth = 2;
    [shapeView setLineCap:kCALineCapRound];
//
//    [self.layer ]
//    [self.layer addSublayer:shapeView];
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
