//
//  FAStrategyDetailProfitViewCell.m
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyDetailProfitViewCell.h"
#import "FAStrategyDetailProfitView.h"

@implementation FAStrategyDetailProfitViewCell

@synthesize imgStrategyDetailProfitView;

@synthesize imgStrategyDetailProfit;


- (void)awakeFromNib {
    
    FAStrategyDetailProfitView *profitView = [[FAStrategyDetailProfitView alloc] initWithFrame:CGRectMake(0, 0, 310, 168)];
    [self.imgStrategyDetailProfit addSubview:profitView];
    self.imgStrategyDetailProfitView = profitView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
