//
//  Two_DaDieProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Two_DaDieProfitPoint.h"

/// <summary>
/// 大升策略损益点。
/// </summary>
@implementation Two_DaDieProfitPoint

/// <summary>
/// 行权点。
/// </summary>
@synthesize StrikePoint;

/// <summary>
/// 打和点。
/// </summary>
@synthesize EqualPoint;

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Two_DaDie;
}

@end
