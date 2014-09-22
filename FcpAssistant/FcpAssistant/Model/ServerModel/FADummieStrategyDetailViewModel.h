//
//  FADummieStrategyDetailViewModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FADummieStrategyViewModelDto.h"

@interface FADummieStrategyDetailViewModel : FADummieStrategyViewModelDto

// 提供者标识。
@property(nonatomic,assign) int ProviderId;

// 策略提供者姓名。
@property(nonatomic,copy) NSString *ProviderName;

// 是否经过认证。
@property(nonatomic,assign) bool IsCertificated;

// QQ号码。
@property(nonatomic,copy) NSString *QQ;

// 微博地址。
@property(nonatomic,copy) NSString *Microblog;

// 星级评价（0 ~ 5，可以有半星），空表示没有评价过。
@property(nonatomic,assign) int Star;
//
///// <summary>
///// 评价次数（人次）。
///// </summary>
//[DataMember]
//public virtual int? AssessCount { get; set; }
//
///// <summary>
///// 评价人数。
///// </summary>
//[DataMember]
//public virtual int? AssessPersons { get; set; }
//
///// <summary>
///// 持仓状况，0 => 当冲 1 => 留仓
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual short? IsOpen
//{
//    get;
//    set;
//}
///// <summary>
///// 策略形态（价格形态），1 => 趋势, 2 => 逆势（盘整）,3 => 套利
///// </summary>
///// <remarks>
///// 该数字来源于Strategy.Type.
///// </remarks>
//[DataMember(EmitDefaultValue = true)]
//public virtual short? PricePatterns
//{
//    get;
//    set;
//}
///// <summary>
///// 策略方向（交易方向），1 => 仅多 2 => 仅空 3 => 双向
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual short? TradingDirection
//{
//    get;
//    set;
//}
///// <summary>
///// 交易频率，1 => 密集 2 => 稀疏
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual short? TransactionFrequency
//{
//    get;
//    set;
//}
//
///// <summary>
///// 起初资产。
///// </summary>
//[DataMember(EmitDefaultValue = true)]
//public virtual int? InitialAssets
//{
//    get;
//    set;
//}
//
//
///// <summary>
///// 胜负记录。
///// </summary>
//[DataMember]
//[Obsolete("WinLoss属性以后将不再支持，请使用。。。")]
//public virtual List<decimal> WinLoss { get; set; }
//
///// <summary>
///// 胜负记录，含平仓时间。
///// </summary>
//[DataMember]
//public virtual List<WinLossViewModel> WinLosses{ get; set; }
//
///// <summary>
///// 策略的“温馨提示和样本外事件”列表。
///// </summary>
//[DataMember]
//public List<StrategyEventViewModel> Events { get; set; }
@end
