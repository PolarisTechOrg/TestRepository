//
//  FAStrategyDetailViewCell.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAStrategyProfitView.h"

@interface FAStrategyInfoViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgStrategyMarked;
@property (weak, nonatomic) IBOutlet UIImageView *imgStrategyStar;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectionPeopleNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblProvider;

@property (weak, nonatomic) IBOutlet UILabel *lblPerformance;
@property (weak, nonatomic) IBOutlet UIImageView *imgPerformanceMap;
@property (weak, nonatomic) IBOutlet UIImageView *imgPerformanceBackMap;
@property (weak, nonatomic) IBOutlet FAStrategyProfitView *imgStrategyProfit;

@property (nonatomic, assign) int StrategyId;

@end
