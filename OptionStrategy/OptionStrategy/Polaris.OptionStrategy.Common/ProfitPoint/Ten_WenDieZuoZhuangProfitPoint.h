//
//  Ten_WenDieZuoZhuangProfitPoint.h
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionProfitPoint.h"
#import "OptionStrategyType.h"

/// <summary>
/// 温跌坐庄策略损益点。
/// </summary>
@interface Ten_WenDieZuoZhuangProfitPoint : OptionProfitPoint

/// <summary>
/// 策略类型。
/// </summary>
@property (getter = getStrategyType, assign) OptionStrategyType StrategyType;

/// <summary>
/// 行权点1。
/// </summary>
@property (nonatomic, assign) double StrikePoint1;

/// <summary>
/// 行权点2。
/// </summary>
@property (nonatomic, assign) double StrikePoint2;

/// <summary>
/// 打和点。
/// </summary>
@property (nonatomic, assign) double EqualPoint;

@end
