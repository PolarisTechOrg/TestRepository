//
//  01_DaShengProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "One_DaShengProfitPoint.h"

/// <summary>
/// 大升策略损益点。
/// </summary>
@implementation One_DaShengProfitPoint

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
    return OptionStrategyType_One_DaSheng;
}

@end
