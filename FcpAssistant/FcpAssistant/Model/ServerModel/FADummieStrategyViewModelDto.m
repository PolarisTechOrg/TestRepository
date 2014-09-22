//
//  FADummieStrategyViewModelDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FADummieStrategyViewModelDto.h"

@implementation FADummieStrategyViewModelDto

// 排序Id。
@synthesize SortId;
// 策略标识。
@synthesize StrategyId;
// 策略名称
@synthesize StrategyName;
// 策略状态，0 => 已冻结 1 => 正常 2 => 已撤销
@synthesize Status;
// 是否被收藏
@synthesize InWishList;
// 实盘累计净获利（实盘绩效）。
@synthesize CumulativeNetProfit;
// 实盘累计收益率（实盘绩效）。
@synthesize CumulativeReturnRatio;
// 跟单人数。
@synthesize FollowNumber;


@end
