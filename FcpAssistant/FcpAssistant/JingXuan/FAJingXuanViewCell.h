//
//  FAJingXuanViewCell.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FAStrategyProfitView.h"
#import "FAChartDto.h"

@interface FAJingXuanViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (copy, nonatomic) NSDictionary *nameIdDict;
@property (retain, nonatomic) UINavigationController *navigationController;

@property (assign, nonatomic) int strategyId1;
@property (retain, nonatomic) FAChartDto *profitChartDto1;
@property (retain, nonatomic) IBOutlet UIButton *btnStrategyName1;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName1;
@property (weak, nonatomic) IBOutlet UIImageView *imgStrategyStar1;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdateDate1;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyStatus1;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectionPeople1;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName1;
@property (weak, nonatomic) IBOutlet UILabel *lblPerformanceNumber1;
@property (weak, nonatomic) IBOutlet UIImageView *imgPerformanceMap1;
@property (weak, nonatomic) IBOutlet UIImageView *imgPerformanceBackMap1;
@property (weak, nonatomic) IBOutlet FAStrategyProfitView *imgStrategyProfit;

@property (assign, nonatomic) int strategyId2;
@property (retain, nonatomic) FAChartDto *profitChartDto2;
@property (weak, nonatomic) IBOutlet UIButton *btnStrategyName2;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName2;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectionPeople2;

@property (assign, nonatomic) int strategyId3;
@property (retain, nonatomic) FAChartDto *profitChartDto3;
@property (weak, nonatomic) IBOutlet UIButton *btnStrategyName3;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName3;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectionPeople3;


- (void)initialNameIdDictionary;
@end
