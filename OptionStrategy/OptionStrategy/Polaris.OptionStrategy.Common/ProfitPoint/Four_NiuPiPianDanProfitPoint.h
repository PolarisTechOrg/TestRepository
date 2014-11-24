//
//  Four_NiuPiPianDanProfitPoint.h
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionProfitPoint.h"
#import "OptionStrategyType.h"

/// <summary>
/// 牛皮偏淡策略损益点。
/// </summary>
@interface Four_NiuPiPianDanProfitPoint : OptionProfitPoint

/// <summary>
/// 策略类型。
/// </summary>
@property (getter = getStrategyType, assign) OptionStrategyType StrategyType;

/// <summary>
/// 行权点。
/// </summary>
@property (nonatomic, assign) double StrikePoint;

/// <summary>
/// 打和点。
/// </summary>
@property (nonatomic, assign) double EqualPoint;

@end
