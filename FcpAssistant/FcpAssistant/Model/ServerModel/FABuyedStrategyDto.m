//
//  FABuyedStrategyDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FABuyedStrategyDto.h"
#import "FAUnderlyingViewModel.h"

@implementation FABuyedStrategyDto

// 组合策略ID。
@synthesize CombineStrategyId;
// 组合策略名称。
@synthesize CombineStrategyName;
// 策略ID。
@synthesize StrategyId;
// 策略名称。
@synthesize StrategyName;
// 标的名称。
@synthesize UnderName;
// 策略产品列表。
@synthesize Underlyings;
// 订购时间。
@synthesize BuyedTime;
/// 星级。
@synthesize Star;
/// 跟单倍数。
@synthesize BuyedQuantity;
/// 策略盈亏。
@synthesize StrategyProfit;
/// 今日盈亏。
@synthesize TodayProfit;
/// 昨日盈亏。
@synthesize YesterdayProfit;

//策略品种数据集合类型
+(Class) Underlyings_class
{
    return [FAUnderlyingViewModel class];
}

@end
