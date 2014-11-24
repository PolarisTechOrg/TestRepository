//
//  Seven_WenZhangProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Seven_WenZhangProfitPoint.h"

/// <summary>
/// 温涨策略损益点。
/// </summary>
@implementation Seven_WenZhangProfitPoint

/// <summary>
/// 行权点1。
/// </summary>
@synthesize StrikePoint1;

/// <summary>
/// 行权点2。
/// </summary>
@synthesize StrikePoint2;

/// <summary>
/// 打和点。
/// </summary>
@synthesize EqualPoint;


/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Seven_WenZhang;
}

@end
