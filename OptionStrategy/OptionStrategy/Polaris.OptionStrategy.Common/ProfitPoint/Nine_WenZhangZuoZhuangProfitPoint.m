//
//  Nine_WenZhangZuoZhuangProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Nine_WenZhangZuoZhuangProfitPoint.h"

/// <summary>
/// 温涨坐庄策略损益点。
/// </summary>
@implementation Nine_WenZhangZuoZhuangProfitPoint

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
    return OptionStrategyType_Nine_WenZhangZuoZhuang;
}

@end
