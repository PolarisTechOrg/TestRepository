//
//  FADummieStrategyViewModelDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FADummieStrategyViewModelDto : NSObject

// 排序Id。
@property(nonatomic,assign) int SortId;

// 策略标识。
@property(nonatomic,assign) int StrategyId;

// 策略名称
@property(nonatomic,copy) NSString *StrategyName;

/// 策略状态，0 => 已冻结 1 => 正常 2 => 已撤销
/// </summary>
@property(nonatomic,assign) int Status;

// 是否被收藏
@property(nonatomic,assign) BOOL InWishList;

// 实盘累计净获利（实盘绩效）。
@property(nonatomic,assign) double CumulativeNetProfit;

// 实盘累计收益率（实盘绩效）。
@property(nonatomic,assign) double  CumulativeReturnRatio;

// 周收益
@property(nonatomic, assign) double WeeklyReturn;

// 胜率
@property(nonatomic, assign) double WinningProbability;

// 策略标的（品种）名称
@property(nonatomic, copy) NSString *UnderName;

///// <summary>
///// 周收益。
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual decimal? WeeklyReturn { get; set; }
//
///// <summary>
///// 日收益。
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual decimal? DailyReturn { get; set; }
//
//
///// <summary>
///// 胜率
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual decimal? WinningProbability
//{
//    get;
//    set;
//}
//

// 跟单人数。
@property(nonatomic,assign) int FollowNumber;

///// <summary>
///// 购买限制
///// </summary>
//[DataMember]
//public virtual int BuyLimit
//{
//    get;
//    set;
//}
//
///// <summary>
///// 已购买数量
///// </summary>
//[DataMember]
//public virtual int BuyedQuantity
//{
//    get;
//    set;
//}
//
///// <summary>
///// 剩余数量
///// </summary>
//[DataMember]
//public virtual int RemQuantity
//{
//    get;
//    set;
//}
//
///// <summary>
///// 剩余数量名称
///// </summary>
//[DataMember]
//public virtual string RemQuantityName
//{
//    get;
//    set;
//}
//
///// <summary>
///// 策略标的（品种）名称。
///// </summary>
//[DataMember]
//public virtual string UnderName
//{
//    get;
//    set;
//}
//
///// <summary>
///// 揭露历史交易信号标识。
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual bool DisclosureHistoricalTransactions
//{
//    get;
//    set;
//}
///// <summary>
///// 交易标的属性。
///// </summary>
//[DataMember]
//public virtual List<UnderlyingPropertyViewModel> Underlyings { get; set; }
//
///// <summary>
///// 信号发送模式。1、自动程序 2、主观发送
///// </summary>
//[DataMember]
//public short? SignalPattern { get; set; }
@end
