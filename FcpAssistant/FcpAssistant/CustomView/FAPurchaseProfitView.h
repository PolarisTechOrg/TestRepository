//
//  FAPurchaseProfitView.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-18.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAPurchaseProfitView : UIView
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
@private NSInteger totalPointCount;
//每点X轴间距
@private CGFloat xIntervalPoint;
//Y轴每点值
@private CGFloat yValuePerPoint;
//损益线颜色
@private UIColor *profitLineColor;
}

@property(nonatomic,retain) NSArray *dataSource;
@end
