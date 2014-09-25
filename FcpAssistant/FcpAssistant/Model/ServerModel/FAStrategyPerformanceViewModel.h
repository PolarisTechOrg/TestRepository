//
//  FAStrategyPerformanceViewModel.h
//  FcpAssistant
//
//  Created by admin on 9/25/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategyPerformanceViewModel : NSObject

@property(nonatomic, assign) double CumulativeNetProfit;

@property(nonatomic, assign) double CumulativeNetReturnRatio;

@property(nonatomic, assign) int StrategyId;

@property(nonatomic, assign) double TotalNetProfit;

@end
