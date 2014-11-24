//
//  Five_TuPoProfitPoint.h
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionProfitPoint.h"
#import "OptionStrategyType.h"

/// <summary>
/// 突破策略损益点。
/// </summary>
@interface Five_TuPoProfitPoint : OptionProfitPoint

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
/// 打和点1。
/// </summary>
@property (nonatomic, assign) double EqualPoint1;

/// <summary>
/// 打和点2。
/// </summary>
@property (nonatomic, assign) double EqualPoint2;

@end
