//
//  FAStrategyProfitView.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PI 3.14159265358979323846

@interface FAStrategyProfitView : UIView
{
@private CGFloat frameWidth;
@private CGFloat frameHeight;
@private CGFloat viewWidth;
@private CGFloat viewHeight;
    
@private CGFloat leftMargin;
@private CGFloat rightMargin;
@private CGFloat topMargin;
@private CGFloat bottomMargin;
    
@private double maxValue;
@private double minValue;
@private CGFloat xInterval;
@private CGFloat yPointValue;
    CAShapeLayer *shapeView;
        CAShapeLayer *fillView;
}

//-(void)setBackgroundColor:(UIColor *) backColor;
//-(UIColor *) getBackgroundColor;

@property(nonatomic,retain) NSArray *dataSource;
@property(nonatomic,retain) UIColor *backgroundColor;
@property(nonatomic,retain) UIColor *profitLineColor;
@end
