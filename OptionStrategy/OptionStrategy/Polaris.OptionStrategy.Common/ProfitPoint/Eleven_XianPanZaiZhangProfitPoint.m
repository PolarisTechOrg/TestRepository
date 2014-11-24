//
//  Eleven_XianPanZaiZhangProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Eleven_XianPanZaiZhangProfitPoint.h"

/// <summary>
/// 先盘在涨策略损益点。
/// </summary>
@implementation Eleven_XianPanZaiZhangProfitPoint

/// <summary>
/// 行权点。
/// </summary>
@synthesize StrikePoint;


/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Eleven_XianPanZaiZhang;
}

@end
