//
//  OptionStrategy.h
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionStrategyType.h"
#import "OptionStrategyDetail.h"
#import "CombineStrategyOrder.h"

#define ARRAY_CAPACITY 32

@interface OptionStrategy : NSObject

/// <summary>
/// 策略类型。
/// </summary>
@property (getter = getStrategyType, assign) OptionStrategyType StrategyType;


/// <summary>
/// 计算期权策略损益明细。
/// </summary>
/// <param name="strategyOrder">委托信息。</param>
/// <returns></returns>
- (OptionStrategyDetail *)CalcOptionStrategyDetail:(CombineStrategyOrder *)strategyOrder;

/// <summary>
/// 校验策略委托是否合法。
/// </summary>
/// <param name="strategyOrder"></param>
/// <returns></returns>
- (BOOL)Verify:(CombineStrategyOrder*) strategyOrder Error:(out NSString *) errorMessage;

/// <summary>
/// 计算期权策略损益明细。
/// </summary>
/// <param name="strategyOrder">委托信息。</param>
/// <returns></returns>
- (OptionStrategyDetail *)InternalCalcOptionStrategyDetail:(CombineStrategyOrder *)strategyOrder;

/// <summary>
/// 校验组合行权价是否可用。
/// </summary>
/// <param name="leftStrikePrice">左侧行权价</param>
/// <param name="rightStrikePrice">右侧行权价</param>
/// <returns></returns>
- (BOOL)VerifyCombineStrikePrice:(NSNumber *)leftStrikePrice RightStrikePrice:(NSNumber *)rightStrikePrice;

/// <summary>
/// 计算期权保证金。
/// </summary>
/// <param name="tradeCost"></param>
/// <param name="instrument"></param>
/// <param name="royalty"></param>
/// <returns></returns>
- (double)CalcOptionMargin:(OptionTradeCost *)tradeCost Instrument:(FcpInstrument *)instrument Royalty:(double)royalty;

- (NSString *)DoubleRound:(double)value;

@end
