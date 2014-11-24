//
//  Eleven_XianPanZaiZhangProfitPoint.h
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionProfitPoint.h"
#import "OptionStrategyType.h"

/// <summary>
/// 先盘在涨策略损益点。
/// </summary>
@interface Eleven_XianPanZaiZhangProfitPoint : OptionProfitPoint

/// <summary>
/// 策略类型。
/// </summary>
@property (getter = getStrategyType, assign) OptionStrategyType StrategyType;

/// <summary>
/// 行权点。
/// </summary>
@property (nonatomic, assign) double StrikePoint;

@end
