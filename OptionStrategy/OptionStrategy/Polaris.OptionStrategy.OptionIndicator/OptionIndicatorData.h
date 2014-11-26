//
//  OptionIndicatorData.h
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

/// <summary>
/// 期权指标数据结构。
/// </summary>
@interface OptionIndicatorData : NSObject

/// <summary>
/// 波动率。
/// </summary>
@property (nonatomic, assign) double Volatility;

/// <summary>
/// Delta值。
/// </summary>
@property (nonatomic, assign) double Delta;

/// <summary>
/// Gamma值。
/// </summary>
@property (nonatomic, assign) double Gamma;

/// <summary>
/// Theta值。
/// </summary>
@property (nonatomic, assign) double Theta;

/// <summary>
/// Vega值。
/// </summary>
@property (nonatomic, assign) double Vega;

/// <summary>
/// Rho值。
/// </summary>
@property (nonatomic, assign) double Rho;


/// <summary>
/// 检查指标数据的有效性。
/// </summary>
/// <returns></returns>
- (BOOL)CheckValidity;

@end
