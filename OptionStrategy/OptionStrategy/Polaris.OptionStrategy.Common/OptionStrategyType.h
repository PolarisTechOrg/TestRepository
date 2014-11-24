//
//  OptionStrategyType.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#ifndef PolarisOptionStrategy_OptionStrategyType_h
#define PolarisOptionStrategy_OptionStrategyType_h

/// <summary>
/// 期权策略类型。
/// </summary>
typedef enum
{
    /// <summary>
    /// 未知。
    /// </summary>
    OptionStrategyType_None = 0,
    
    /// <summary>
    /// 大升策略。
    /// </summary>
    OptionStrategyType_One_DaSheng = 1,
    
    /// <summary>
    /// 大跌策略。
    /// </summary>
    OptionStrategyType_Two_DaDie = 2,
    
    /// <summary>
    /// 牛皮偏好策略。
    /// </summary>
    OptionStrategyType_Three_NiuPiPianHao = 3,
    
    /// <summary>
    /// 牛皮偏淡策略。
    /// </summary>
    OptionStrategyType_Four_NiuPiPianDan = 4,
    
    /// <summary>
    /// 突破策略。
    /// </summary>
    OptionStrategyType_Five_TuPo = 5,
    
    /// <summary>
    /// 牛皮策略。
    /// </summary>
    OptionStrategyType_Six_NiuPi = 6,
    
    /// <summary>
    /// 温涨策略。
    /// </summary>
    OptionStrategyType_Seven_WenZhang = 7,
    
    /// <summary>
    /// 温跌策略。
    /// </summary>
    OptionStrategyType_Eight_WenDie = 8,
    
    /// <summary>
    /// 温涨坐庄策略。
    /// </summary>
    OptionStrategyType_Nine_WenZhangZuoZhuang = 9,
    
    /// <summary>
    /// 温跌坐庄策略。
    /// </summary>
    OptionStrategyType_Ten_WenDieZuoZhuang = 10,
    
    /// <summary>
    /// 先盘在涨策略。
    /// </summary>
    OptionStrategyType_Eleven_XianPanZaiZhang = 11,
    
    /// <summary>
    /// 先盘在跌策略。
    /// </summary>
    OptionStrategyType_Twelve_XianPanZaiDie = 12
    
} OptionStrategyType;

#endif
