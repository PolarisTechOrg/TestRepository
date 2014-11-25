//
//  NormalDistribution.h
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
/// <summary>
/// 正态分布（高斯分布）函数类。
/// </summary>
@interface NormalDistribution : NSObject

/*
 参考链接：
 * http://home.online.no/~pjacklam/notes/invnorm/
 * http://www.netlib.org/specfun/erf
 * http://home.online.no/~pjacklam/notes/invnorm/impl/lea/lea.c
 * http://home.online.no/~pjacklam/notes/invnorm/impl/karimov/StatUtil.java
 */

/// <summary>
/// 正态分布的概率密度函数（钟形曲线）。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns></returns>
/// <exception cref="System.ArgumentException">方差参数小于等于零。</exception>
/// <remarks>PDF：Probability Density Function的简称。</remarks>
+ (double)NormDistPDF:(double)x Mean:(double)mean Sigma:(double)sigma;

/// <summary>
/// 标准正态分布的概率密度函数（钟形曲线）。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <returns></returns>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
/// <remarks>PDF：Probability Density Function的简称。</remarks>
+ (double)StdNormDistPDF:(double)x;

/// <summary>
/// 正态分布的累积分布函数。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns>正态分布点对应的概率值，结果大于等于0且小于等于1，由于精度原因，当分布点为近似负无穷值时返回0，为近似正无穷值时返回1。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值参数不建议取绝对值过大的值。</remarks>
+ (double)NormDistCDF:(double)x Mean:(double)mean Sigma:(double)sigma;

/// <summary>
/// 标准正态分布的累积分布函数。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <returns>正态分布点对应的概率值，结果大于等于0且小于等于1，由于精度原因，当分布点为近似负无穷值时返回0，为近似正无穷值时返回1。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)StdNormDistCDF:(double)x;

/// <summary>
/// 正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
+ (double)InvNormDistCDF:(double)probability Mean:(double)mean Sigma:(double)sigma;

/// <summary>
/// 正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <param name="highPrecision">是否返回高精度值。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
+ (double)InvNormDistCDF:(double)probability Mean:(double)mean Sigma:(double)sigma HighPrecision:(BOOL)highPrecision;

/// <summary>
/// 标准正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)InvStdNormDistCDF:(double)probability;

/// <summary>
/// 标准正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="highPrecision">是否返回高精度值。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)InvStdNormDistCDF:(double)probability HighPrecision:(BOOL)highPrecision;

@end
