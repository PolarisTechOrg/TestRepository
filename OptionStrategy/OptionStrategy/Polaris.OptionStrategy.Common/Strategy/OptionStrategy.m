//
//  OptionStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <math.h>
#import "OptionStrategy.h"

@implementation OptionStrategy

- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_None;
}

/// <summary>
/// 计算期权策略损益明细。
/// </summary>
/// <param name="strategyOrder">委托信息。</param>
/// <returns></returns>
- (OptionStrategyDetail *)CalcOptionStrategyDetail:(CombineStrategyOrder *)strategyOrder
{
    NSString *errorMessage = nil;
    if([self Verify:strategyOrder Error:errorMessage] == false)
    {
        @throw [NSException exceptionWithName:@"CalcOptionStrategyDetail" reason:errorMessage userInfo:nil];
    }
    
    return [self InternalCalcOptionStrategyDetail:strategyOrder];
}

/// <summary>
/// 校验策略委托是否合法。
/// </summary>
/// <param name="strategyOrder"></param>
/// <returns></returns>
- (BOOL)Verify:(CombineStrategyOrder*) strategyOrder Error:(out NSString *) errorMessage
{
    return NO;
}

/// <summary>
/// 计算期权策略损益明细。
/// </summary>
/// <param name="strategyOrder">委托信息。</param>
/// <returns></returns>
- (OptionStrategyDetail *)InternalCalcOptionStrategyDetail:(CombineStrategyOrder *)strategyOrder
{
    return nil;
}

/// <summary>
/// 校验组合行权价是否可用。
/// </summary>
/// <param name="leftStrikePrice">左侧行权价</param>
/// <param name="rightStrikePrice">右侧行权价</param>
/// <returns></returns>
- (BOOL)VerifyCombineStrikePrice:(NSNumber *)leftStrikePrice RightStrikePrice:(NSNumber *)rightStrikePrice
{
    return NO;
}

/// <summary>
/// 计算期权保证金。
/// </summary>
/// <param name="tradeCost"></param>
/// <param name="instrument"></param>
/// <param name="royalty"></param>
/// <returns></returns>
- (double)CalcOptionMargin:(OptionTradeCost *)tradeCost Instrument:(FcpInstrument *)instrument Royalty:(double)royalty
{
    double margin = 0;
    
    switch (instrument.Market)
    {
        case FcpMarket_CZCE:
            margin = royalty + tradeCost.FixedMargin;
            break;
        case FcpMarket_DCE:
            margin = royalty + tradeCost.FixedMargin;
            break;
        case FcpMarket_CFFE:
            margin = royalty + tradeCost.FixedMargin;
            break;
        case FcpMarket_SFE:
            margin = fmax(tradeCost.FixedMargin + royalty, tradeCost.MiniMargin * tradeCost.VolumeMultiple);
            break;
        default:
            @throw [NSException exceptionWithName:@"CalcOptionMargin" reason:@"Invalid market" userInfo:nil];
    }
    
    return  margin;
}

- (NSString *)DoubleRound:(double)value
{
    return [NSString stringWithFormat:@"%f", round(value)];
}
@end
