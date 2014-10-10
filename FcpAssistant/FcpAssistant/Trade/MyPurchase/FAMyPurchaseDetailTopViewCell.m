//
//  FAMyPurchaseDetailTopViewCell.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyPurchaseDetailTopViewCell.h"
#import "FAStrategyDetailController.h"

@implementation FAMyPurchaseDetailTopViewCell

@synthesize rootNavController;
@synthesize strategyId;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnDetailClick:(id)sender
{
    FAStrategyDetailController *detailController = [[FAStrategyDetailController alloc] init];
    detailController.strategyId = strategyId;
    
    [self.rootNavController pushViewController:detailController animated:YES];
}
@end
