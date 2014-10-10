//
//  FAMyPurchaseDetailProfitViewCell.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyPurchaseDetailProfitViewCell.h"
#import "FAPurchaseProfitView.h"
@implementation FAMyPurchaseDetailProfitViewCell

@synthesize imgPurchaseProfit;

- (void)awakeFromNib
{
    FAPurchaseProfitView *profitView = [[FAPurchaseProfitView alloc] initWithFrame:CGRectMake(0, 0, 320, 168)];
    [self.imgProfit addSubview:profitView];
    self.imgPurchaseProfit = profitView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
