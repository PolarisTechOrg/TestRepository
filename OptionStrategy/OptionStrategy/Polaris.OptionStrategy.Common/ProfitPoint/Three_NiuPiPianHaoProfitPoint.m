//
//  Three_NiuPiPianHaoProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Three_NiuPiPianHaoProfitPoint.h"

/// <summary>
/// 牛皮偏好损益点。
/// </summary>
@implementation Three_NiuPiPianHaoProfitPoint

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
    return OptionStrategyType_Three_NiuPiPianHao;
}

@end
