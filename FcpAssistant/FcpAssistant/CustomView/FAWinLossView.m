//
//  FAWinLossView.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAWinLossView.h"
#import "FAUtility.h"
#import "FAWinLossViewModel.h"

@implementation FAWinLossView

- (void)drawRect:(CGRect)rect
{
    @try
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [self calculatePara];
        [self drawbackGround:context];
        [self drawBorder:context];
//        [self drawSpiterLine:context];
//        [self drawTickMark:context];
//        if(self.dataSource !=nil && self.dataSource.count >0)
//        {
//            [self drawProfitLine:context];
//        }
        
        [self drawWinLoss:context];
        
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
    leftMargin = 15.0;
    topMargin = 10.0;
    itemXInterval = 35.0;
    itemYInterval = 25.0;
    itemRadius = 10.0;
    winItemColor = [UIColor colorWithRed:255.0/255 green:3.0/255 blue:3.0/255 alpha:1.0].CGColor;
    drawItemColor =[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0].CGColor;
    lossItemColor = [UIColor colorWithRed:153.0/255 green:255.0/255 blue:3.0/255 alpha:1.0].CGColor;
    
}

//填充背景
-(void)drawbackGround:(CGContextRef) context
{
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
}

//绘制边框
-(void)drawBorder:(CGContextRef) context
{
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextStrokeRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
}

-(void) drawWinLoss:(CGContextRef) context
{
    if(self.dataSource == nil || self.dataSource.count <=0)
    {
        return;
    }
    
    for (int i=0;i<8;i++)
    {
        if(i>=self.dataSource.count)
        {
            break;
        }
        
        NSArray *subArray = self.dataSource[i];
        if(subArray ==nil || subArray.count <=0)
        {
            break;
        }
        
        for (int j=0; j<5;j++)
        {
            if(j< subArray.count)
            {
                FAWinLossViewModel *entity = subArray[j];
                if(entity.Profit >0)
                {
                    CGContextSetFillColorWithColor(context, winItemColor);
                }
                else if(entity.Profit <0)
                {
                    CGContextSetFillColorWithColor(context, lossItemColor);
                }
                else
                {
                    CGContextSetFillColorWithColor(context, drawItemColor);
                }
                CGFloat xPos = leftMargin + i*itemXInterval + itemRadius;
                CGFloat yPos = topMargin + j* itemYInterval +itemRadius;
                CGContextAddArc(context, xPos, yPos, itemRadius, 0,2*PI, 0);
                CGContextDrawPath(context, kCGPathEOFill);
            }
        }
    }
}

@end
