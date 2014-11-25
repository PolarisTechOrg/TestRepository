//
//  NormalDistribution.m
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "NormalDistribution.h"
#import <math.h>

static double PROB_LOW = 0.02425;
static double PROB_HIGH = 1 - 0.02425;                                  // 1 - PROB_LOW

static double SQRT_2 = M_SQRT2;                                         // Math.Sqrt(2)
static double SQRT_PI_RECIPROCAL = M_2_SQRTPI / 2;                      // 1 / Math.Sqrt(Math.PI);
static double THRESHOLD = 0.46875 * M_SQRT2;                            // 0.46875 * SQRT_2;
static double SQRT_2_MUL_4 = 4 * M_SQRT2;                               // 4 * SQRT_2;

static double SQRT_2PI = (2 * M_SQRT2) / M_2_SQRTPI;                    // Math.Sqrt(2 * Math.PI);
static double SQRT_2PI_RECIPROCAL = 1 / ((2 * M_SQRT2) / M_2_SQRTPI);   // 1 / SQRT_2PI;
static double SQRT_2_RECIPROCAL = 1 / M_SQRT2;                          // 1 / SQRT_2;

// Coefficients in rational approximations.(Pseudo-code Algorithm of Inverse Normal Cumulative Distribution)
static double ICDF_A[] = { -3.969683028665376e+01, 2.209460984245205e+02, -2.759285104469687e+02,
    1.383577518672690e+02, -3.066479806614716e+01, 2.506628277459239e+00 };

static double ICDF_B[] = { -5.447609879822406e+01, 1.615858368580409e+02, -1.556989798598866e+02,
    6.680131188771972e+01, -1.328068155288572e+01 };

static double ICDF_C[] = { -7.784894002430293e-03, -3.223964580411365e-01, -2.400758277161838e+00,
    -2.549732539343734e+00, 4.374664141464968e+00, 2.938163982698783e+00 };

static double ICDF_D[] = { 7.784695709041462e-03, 3.224671290700398e-01, 2.445134137142996e+00,
    3.754408661907416e+00 };

// Coefficients in rational approximations.(Cumulative Distribution Function)
static double NORM_A[] = { 1.161110663653770e-02, 3.951404679838207e-01, 2.846603853776254e+01,
    1.887426188426510e+02, 3.209377589138469e+03 };

static double NORM_B[] = { 1.767766952966369e-01, 8.344316438579620e+00, 1.725514762600375e+02,
    1.813893686502485e+03, 8.044716608901563e+03 };

static double NORM_C[] = { 2.15311535474403846e-08, 5.64188496988670089e-01, 8.88314979438837594e+00,
    6.61191906371416295e+01, 2.98635138197400131e+02, 8.81952221241769090e+02,
    1.71204761263407058e+03, 2.05107837782607147e+03, 1.23033935479799725e+03 };

static double NORM_D[] = { 1.00000000000000000e+00, 1.57449261107098347e+01, 1.17693950891312499e+02,
    5.37181101862009858e+02, 1.62138957456669019e+03, 3.29079923573345963e+03,
    4.36261909014324716e+03, 3.43936767414372164e+03, 1.23033935480374942e+03 };

static double NORM_P[] = { 1.63153871373020978e-02, 3.05326634961232344e-01, 3.60344899949804439e-01,
    1.25781726111229246e-01, 1.60837851487422766e-02, 6.58749161529837803e-04 };

static double NORM_Q[] = { 1.00000000000000000e+00, 2.56852019228982242e+00, 1.87295284992346047e+00,
    5.27905102951428412e-01, 6.05183413124413191e-02, 2.33520497626869185e-03 };

@implementation NormalDistribution


/// <summary>
/// 正态分布的概率密度函数（钟形曲线）。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns></returns>
/// <exception cref="System.ArgumentException">方差参数小于等于零。</exception>
/// <remarks>PDF：Probability Density Function的简称。</remarks>
+ (double)NormDistPDF:(double)x Mean:(double)mean Sigma:(double)sigma
{
    if (sigma <= 0)
    {
        @throw [NSException exceptionWithName:@"NormDistPDF" reason:@"Sigma argument can not less than or equal to zero." userInfo:nil];
    }
    
    double sigmaReciprocal = 1 / sigma;
    double temp = x - mean;
    return sigmaReciprocal * SQRT_2PI_RECIPROCAL * exp(temp * temp * -0.5 * sigmaReciprocal * sigmaReciprocal);
}

/// <summary>
/// 标准正态分布的概率密度函数（钟形曲线）。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <returns></returns>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
/// <remarks>PDF：Probability Density Function的简称。</remarks>
+ (double)StdNormDistPDF:(double)x
{
    return SQRT_2PI_RECIPROCAL * exp(x * x * -0.5);
}

/// <summary>
/// 正态分布的累积分布函数。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns>正态分布点对应的概率值，结果大于等于0且小于等于1，由于精度原因，当分布点为近似负无穷值时返回0，为近似正无穷值时返回1。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值参数不建议取绝对值过大的值。</remarks>
+ (double)NormDistCDF:(double)x Mean:(double)mean Sigma:(double)sigma
{
    if (sigma <= 0)
    {
        @throw [NSException exceptionWithName:@"" reason:@"Sigma argument can not less than or equal to zero." userInfo:nil];
    }
    
    return [NormalDistribution StdNormDistCDF:(x - mean) / sigma];
}

/// <summary>
/// 标准正态分布的累积分布函数。
/// </summary>
/// <param name="x">正态分布点。</param>
/// <returns>正态分布点对应的概率值，结果大于等于0且小于等于1，由于精度原因，当分布点为近似负无穷值时返回0，为近似正无穷值时返回1。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)StdNormDistCDF:(double)x
{
    double y, z, result;
    y = abs(x);
    
    if (y <= THRESHOLD)
    {
        /* evaluate erf() for |x| <= sqrt(2)*0.46875 */
        z = y * y;
        y = x * ((((NORM_A[0] * z + NORM_A[1]) * z + NORM_A[2]) * z + NORM_A[3]) * z + NORM_A[4]) /
        ((((NORM_B[0] * z + NORM_B[1]) * z + NORM_B[2]) * z + NORM_B[3]) * z + NORM_B[4]);
        result = 0.5 + y;
    }
    else
    {
        z = 0.5 * exp(-0.5 * y * y);
        if (y <= SQRT_2_MUL_4)
        {
            /* evaluate erfc() for sqrt(2)*0.46875 < |x| <= sqrt(2)*4.0 */
            y /= SQRT_2;
            y = ((((((((NORM_C[0] * y + NORM_C[1]) * y + NORM_C[2]) * y + NORM_C[3]) * y + NORM_C[4]) * y + NORM_C[5]) * y + NORM_C[6]) * y + NORM_C[7]) * y + NORM_C[8]) /
            ((((((((NORM_D[0] * y + NORM_D[1]) * y + NORM_D[2]) * y + NORM_D[3]) * y + NORM_D[4]) * y + NORM_D[5]) * y + NORM_D[6]) * y + NORM_D[7]) * y + NORM_D[8]);
            y *= z;
        }
        else
        {
            /* evaluate erfc() for |x| > sqrt(2)*4.0 */
            z *= SQRT_2 / y;
            y = 2 / (y * y);
            y = y * (((((NORM_P[0] * y + NORM_P[1]) * y + NORM_P[2]) * y + NORM_P[3]) * y + NORM_P[4]) * y + NORM_P[5]) /
            (((((NORM_Q[0] * y + NORM_Q[1]) * y + NORM_Q[2]) * y + NORM_Q[3]) * y + NORM_Q[4]) * y + NORM_Q[5]);
            y = z * (SQRT_PI_RECIPROCAL - y);
        }
        
        result = x < 0 ? y : 1 - y;
    }
    
    assert(result >= 0 && result <= 1);
    return result;
}

/// <summary>
/// 正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
+ (double)InvNormDistCDF:(double)probability Mean:(double)mean Sigma:(double)sigma
{
    return [NormalDistribution InvNormDistCDF:probability Mean:mean Sigma:sigma HighPrecision:YES];
}

/// <summary>
/// 正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="mean">均值。</param>
/// <param name="sigma">方差(标准差)。</param>
/// <param name="highPrecision">是否返回高精度值。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
+ (double)InvNormDistCDF:(double)probability Mean:(double)mean Sigma:(double)sigma HighPrecision:(BOOL)highPrecision
{
    if (sigma <= 0)
    {
        @throw [NSException exceptionWithName:@"InvNormDistCDF" reason:@"Sigma argument can not less than or equal to zero." userInfo:nil];
    }
    
    double d = [NormalDistribution InvStdNormDistCDF:probability HighPrecision:highPrecision];
    return mean + sigma * d;
}

/// <summary>
/// 标准正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)InvStdNormDistCDF:(double)probability
{
    return [NormalDistribution InvStdNormDistCDF:probability HighPrecision:YES];
}

/// <summary>
/// 标准正态分布的累积分布函数的反函数。
/// </summary>
/// <param name="probability">概率值，大于0且小于1。</param>
/// <param name="highPrecision">是否返回高精度值。</param>
/// <returns>概率值对应的正态分布点。</returns>
/// <remarks>CDF:CumulativeDistributionFunction的简称。</remarks>
/// <remarks>均值Mean=0，方差Sigma=1。</remarks>
+ (double)InvStdNormDistCDF:(double)probability HighPrecision:(BOOL)highPrecision
{
    if (probability >= 1 || probability <= 0)
    {
        @throw [NSException exceptionWithName:@"InvStdNormDistCDF" reason:@"Invalid probability value." userInfo:nil];
    }
    
    double result;
    if (probability < PROB_LOW)
    {
        // Rational approximation for lower region:
        double q = sqrt(-2 * log(probability));
        result = (((((ICDF_C[0] * q + ICDF_C[1]) * q + ICDF_C[2]) * q + ICDF_C[3]) * q + ICDF_C[4]) * q + ICDF_C[5]) /
        ((((ICDF_D[0] * q + ICDF_D[1]) * q + ICDF_D[2]) * q + ICDF_D[3]) * q + 1);
    }
    else if (probability > PROB_HIGH)
    {
        // Rational approximation for upper region:
        double q = sqrt(-2 * log(1 - probability));
        result = -(((((ICDF_C[0] * q + ICDF_C[1]) * q + ICDF_C[2]) * q + ICDF_C[3]) * q + ICDF_C[4]) * q + ICDF_C[5]) /
        ((((ICDF_D[0] * q + ICDF_D[1]) * q + ICDF_D[2]) * q + ICDF_D[3]) * q + 1);
    }
    else
    {
        // Rational approximation for central region:
        double q = probability - 0.5;
        double r = q * q;
        result = (((((ICDF_A[0] * r + ICDF_A[1]) * r + ICDF_A[2]) * r + ICDF_A[3]) * r + ICDF_A[4]) * r + ICDF_A[5]) * q /
        (((((ICDF_B[0] * r + ICDF_B[1]) * r + ICDF_B[2]) * r + ICDF_B[3]) * r + ICDF_B[4]) * r + 1);
    }
    
    if (highPrecision)
    {
        result = [NormalDistribution Refine:result Probability:probability];
    }
    return result;
}

+ (double)Refine:(double)x Probability:(double)probability
{
    /* The relative error of the approximation has absolute value less
     than 1.15e-9.  One iteration of Halley's rational method (third
     order) gives full machine precision... */
    
    /*
     测试中发现当x>0.999开始有极微小误差，x越接近1，误差相对越大，但总体精度还是比较高。
     测试结果与Excel计算公式比较得到。
     */
    
    //Debug.Assert(probability > 0 && probability < 1);
    //double t = 0.5 * ErrorFunction.ERFC(-x * SQRT_2_RECIPROCAL) - probability;
    //t *= SQRT_2PI * Math.Exp(x * x * 0.5);
    //return x - t / (1 + x * t * 0.5);
    
    // transform stdnormal_cdf(x)=(erfc(-x/sqrt(2)))/2
    assert(probability > 0 && probability < 1);
    double t = [NormalDistribution StdNormDistCDF:x] - probability;
    t *= SQRT_2PI * exp(x * x * 0.5);
    return x - t / (1 + x * t * 0.5);
}

@end
