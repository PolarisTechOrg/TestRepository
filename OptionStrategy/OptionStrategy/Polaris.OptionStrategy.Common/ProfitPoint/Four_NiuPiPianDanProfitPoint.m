//
//  Four_NiuPiPianDanProfitPoint.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Four_NiuPiPianDanProfitPoint.h"

/// <summary>
/// 牛皮偏淡策略损益点。
/// </summary>
@implementation Four_NiuPiPianDanProfitPoint

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
    return OptionStrategyType_Four_NiuPiPianDan;
}

@end
