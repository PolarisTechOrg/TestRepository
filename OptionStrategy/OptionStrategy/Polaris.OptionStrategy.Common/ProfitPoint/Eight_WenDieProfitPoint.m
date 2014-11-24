//
//  Eight_WenDieProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Eight_WenDieProfitPoint.h"

/// <summary>
/// 温跌策略损益点。
/// </summary>
@implementation Eight_WenDieProfitPoint

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
    return OptionStrategyType_Eight_WenDie;
}

@end
