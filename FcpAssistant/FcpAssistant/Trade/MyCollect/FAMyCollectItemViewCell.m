//
//  FAMyCollectItemViewCell.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-19.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyCollectItemViewCell.h"
#import "FAStrategyProfitView.h"

@implementation FAMyCollectItemViewCell


- (void)awakeFromNib
{
    FAStrategyProfitView *profitView = [[FAStrategyProfitView alloc] initWithFrame:CGRectMake(0, 0, 118, 48)];
    [self.imgProfitLine addSubview:profitView];
    self.imgStrategyProfit = profitView;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
