//
//  Five_TuPoProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Five_TuPoProfitPoint.h"

/// <summary>
/// 突破策略损益点。
/// </summary>
@implementation Five_TuPoProfitPoint

/// <summary>
/// 行权点1。
/// </summary>
@synthesize StrikePoint1;

/// <summary>
/// 行权点2。
/// </summary>
@synthesize StrikePoint2;

/// <summary>
/// 打和点1。
/// </summary>
@synthesize EqualPoint1;

/// <summary>
/// 打和点2。
/// </summary>
@synthesize EqualPoint2;

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Five_TuPo;
}

@end
