//
//  FAStrategyDetailLatedRecordViewCell.m
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyDetailLatedRecordViewCell.h"
#import "FAWinLossView.h"

@implementation FAStrategyDetailLatedRecordViewCell

- (void)awakeFromNib
{
    FAWinLossView *winLossView = [[FAWinLossView alloc] initWithFrame:CGRectMake(0, 0, 294, 140)];
    [self.imgLatedWinLost addSubview:winLossView];
    self.imgWinLoss = winLossView;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
