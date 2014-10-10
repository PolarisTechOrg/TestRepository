//
//  FAJingXuanViewCell.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAJingXuanViewCell.h"
#import "FAJingXuanController.h"
#import "FAStrategyDetailController.h"

@implementation FAJingXuanViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)strategyNamePressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *txt = btn.titleLabel.text;
    
    UITableView *superView = (UITableView *)self.superview;
    FAJingXuanController *superController = (FAJingXuanController *)superView.dataSource;
    
    FAStrategyDetailController *controller = [[FAStrategyDetailController alloc] init];
    controller.strategyId = 377;
    controller.hidesBottomBarWhenPushed = YES;
    [superController.navigationController pushViewController:controller animated:YES];
}
@end
