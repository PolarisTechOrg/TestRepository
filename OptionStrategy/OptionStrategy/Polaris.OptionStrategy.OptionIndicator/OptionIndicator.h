//
//  OptionIndicator.h
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionIndicatorData.h"
#import "FcpOptionsType.h"

@interface OptionIndicator : NSObject
{
    OptionIndicatorData *m_indicatorData;
}

/// <summary>
/// 期权类型
/// </summary>
@property (nonatomic, assign) FcpOptionsType OptionType;

/// <summary>
/// 期权执行价格。
/// </summary>
@property (nonatomic, assign) double StrikePrice;

/// <summary>
/// 期权标的物价格。
/// </summary>
@property (nonatomic, assign) double UnderlyingPrice;

/// <summary>
/// 到期时间，年化数值。
/// </summary>
@property (nonatomic, assign) double MaturityTime;

/// <summary>
/// 无风险利率，年化数值。
/// </summary>
@property (nonatomic, assign) double RiskFreeRate;

/// <summary>
/// 波动率。
/// </summary>
@property (nonatomic, assign) double Volatility;

/// <summary>
/// 期权Delta值。
/// </summary>
@property (nonatomic, assign) double OptionDelta;

/// <summary>
/// 期权Gamma值。
/// </summary>
@property (nonatomic, assign) double OptionGamma;

/// <summary>
/// 期权Theta值。
/// </summary>
@property (nonatomic, assign) double OptionTheta;

/// <summary>
/// 期权Vega值。
/// </summary>
@property (nonatomic, assign) double OptionVega;

/// <summary>
/// 期权Rho值。
/// </summary>
@property (nonatomic, assign) double OptionRho;


/// <summary>
/// 根据指定参数计算期权指标数据。
/// </summary>
/// <param name="optionType">期权类型。</param>
/// <param name="strikePrice">执行价格。</param>
/// <param name="underlyingPrice">标的物价格。</param>
/// <param name="volatility">波动率。</param>
/// <param name="maturityTime">到期时间，年化数值。</param>
/// <param name="r">无风险利率，年化数值。</param>
/// <returns>期权指标数据结构。</returns>
/// <remarks>无参数构造函数的实例，可通过此方法计算期权指标。</remarks>
/// <remarks>所有Double型参数数值需>0。</remarks>
- (OptionIndicatorData *)CalcIndicator:(double)volatility OptionType:(FcpOptionsType)optionType StrikePrice:(double)strikePrice UnderlyingPrice:(double)underlyingPrice maturityTime:(double) maturityTime Ratio:(double)r;

/// <summary>
/// 根据指定参数计算期权指标数据。
/// </summary>
/// <param name="optionType">期权类型。</param>
/// <param name="strikePrice">执行价格。</param>
/// <param name="underlyingPrice">标的物价格。</param>
/// <param name="maturityTime">到期时间，年化数据。</param>
/// <param name="r">无风险利率，年化数值。</param>
/// <param name="premium">期权价格。</param>
/// <returns>期权指标数据结构。</returns>
/// <remarks>无参数构造函数的实例，可通过此方法计算期权指标，波动率数值通过参数期权价格计算。</remarks>
/// <remarks>所有Double型参数数值需>0。</remarks>
- (OptionIndicatorData *)CalcIndicator:(FcpOptionsType)optionType StrikePrice:(double)strikePrice UnderlyingPrice:(double)underlyingPrice MaturityTime:(double)maturityTime Ratio:(double)r Premium:(double)premium;

/// <summary>
/// 根据指定参数计算期权指标数据。
/// </summary>
/// <param name="underlyingPrice">标的物价格。</param>
/// <param name="maturityTime">到期时间，年化数据。</param>
/// <returns>期权指标数据结构。</returns>
/// <remarks>其它参数使用实例原有数据。</remarks>
/// <remarks>所有Double型参数数值需>0。</remarks>
- (OptionIndicatorData *)CalcIndicator:(double)underlyingPrice MaturityTime:(double) maturityTime;

/// <summary>
/// 根据指定参数计算期权指标数据。
/// </summary>
/// <param name="underlyingPrice">标的物价格。</param>
/// <param name="maturityTime">到期时间，年化数据。</param>
/// <param name="premium">期权价格。</param>
/// <returns>期权指标数据结构。</returns>
/// <remarks>此方法会通过当前权利金计算新的波动率，其它参数使用实例原有数据。</remarks>
/// <remarks>所有Double型参数数值需>0。</remarks>
- (OptionIndicatorData *)CalcIndicator:(double)underlyingPrice MaturityTime:(double)maturityTime Premium:(double)premium;

@end
