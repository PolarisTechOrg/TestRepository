//
//  FAStrategyProfitView.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyProfitView : UIView
{
@private double maxValue;
@private double minValue;
@private CGFloat xInterval;
@private CGFloat yPointValue;
}

//-(void)setBackgroundColor:(UIColor *) backColor;
//-(UIColor *) getBackgroundColor;

@property(nonatomic,retain) NSArray *dataSource;
@property(nonatomic,retain) UIColor *backgroundColor;
@property(nonatomic,retain) UIColor *profitLineColor;
@end
