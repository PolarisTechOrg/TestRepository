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
#import "FAStrategyProfitView.h"

@implementation FAJingXuanViewCell

@synthesize nameIdDict;
@synthesize navigationController;

@synthesize strategyId1;
@synthesize profitChartDto1;
@synthesize winLossesChart1;
@synthesize strategyId2;
@synthesize profitChartDto2;
@synthesize winLossesChart2;
@synthesize strategyId3;
@synthesize profitChartDto3;
@synthesize winLossesChart3;


- (void)awakeFromNib
{
    FAStrategyProfitView *profitView = [[FAStrategyProfitView alloc] initWithFrame:CGRectMake(0, 0, 118, 48)];
    [self.imgPerformanceMap1 addSubview:profitView];
    self.imgStrategyProfit = profitView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// after cell initialization
- (void)initialNameIdDictionary
{
    nameIdDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:strategyId1], _btnStrategyName1.titleLabel.text, [NSNumber numberWithInt:strategyId2], _btnStrategyName2.titleLabel.text, [NSNumber numberWithInt:strategyId3], _btnStrategyName3.titleLabel.text, nil];
}

- (IBAction)strategyNamePressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *txt = btn.titleLabel.text;
    
    FAStrategyDetailController *controller = [[FAStrategyDetailController alloc] init];
    int strategyId = [[self.nameIdDict objectForKey:txt] intValue];
    controller.strategyId = strategyId;
    controller.profitCharDto = profitChartDto1;
    controller.latedWinlosses = winLossesChart1;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)strategyName2Pressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *txt = btn.titleLabel.text;
    
    FAStrategyDetailController *controller = [[FAStrategyDetailController alloc] init];
    int strategyId = [[self.nameIdDict objectForKey:txt] intValue];
    controller.strategyId = strategyId;
    controller.profitCharDto = profitChartDto2;
    controller.latedWinlosses = winLossesChart2;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)strategyName3Pressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *txt = btn.titleLabel.text;
    
    FAStrategyDetailController *controller = [[FAStrategyDetailController alloc] init];
    int strategyId = [[self.nameIdDict objectForKey:txt] intValue];
    controller.strategyId = strategyId;
    controller.profitCharDto = profitChartDto3;
    controller.latedWinlosses = winLossesChart3;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
