//
//  FALargeProfitController.h
//  FcpAssistant
//
//  Created by admin on 10/16/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAStrategyDetailProfitView.h"
#import "FAChartDto.h"

@interface FALargeProfitController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgLargeProfit;

@property (weak, nonatomic) IBOutlet FAStrategyDetailProfitView *imgLargeProfitView;

@property (weak, nonatomic) FAChartDto *profitChartDto;

@property (assign, nonatomic) int strategyId;
@end
