//
//  FAStrategyDetailViewCell.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyInfoViewCell.h"

@implementation FAStrategyInfoViewCell

@synthesize StrategyId;


- (void)awakeFromNib
{    
    FAStrategyProfitView *profitView = [[FAStrategyProfitView alloc] initWithFrame:CGRectMake(0, 0, 118, 48)];
    [self.imgPerformanceMap addSubview:profitView];
    self.imgStrategyProfit = profitView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
