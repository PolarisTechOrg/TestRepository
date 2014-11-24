//
//  Twelve_XianPanZaiDieProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Twelve_XianPanZaiDieProfitPoint.h"

/// <summary>
/// 先盘在跌策略损益点。
/// </summary>
@implementation Twelve_XianPanZaiDieProfitPoint

/// <summary>
/// 行权点。
/// </summary>
@synthesize StrikePoint;


/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Twelve_XianPanZaiDie;
}

@end
