//
//  PTFcpOptionInstrCommRate.h
//  PolarisCtpDriver
//
//  Created by admin on 11/24/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

/// 当前期权合约手续费的详细内容
@interface PTFcpOptionInstrCommRate : NSObject

/// <summary>
/// 合约代码
/// </summary>
@property NSString* InstrumentID;

/// <summary>
/// 投资者范围
/// </summary>
@property PTFcpInvestorRangeType InvestorRange;

/// <summary>
/// 经纪公司代码
/// </summary>
@property NSString* BrokerID;

/// <summary>
/// 投资者代码				char 13
/// </summary>
@property NSString* InvestorID;

/// <summary>
/// 开仓手续费率
/// </summary>
@property double OpenRatioByMoney;

/// <summary>
/// 开仓手续费
/// </summary>
@property double OpenRatioByVolume;

/// <summary>
/// 平仓手续费率
/// </summary>
@property double CloseRatioByMoney;

/// <summary>
/// 平仓手续费
/// </summary>
@property double CloseRatioByVolume;

/// <summary>
/// 平今手续费率
/// </summary>
@property double CloseTodayRatioByMoney;

/// <summary>
/// 平今手续费
/// </summary>
@property double CloseTodayRatioByVolume;

/// <summary>
/// 执行手续费率
/// </summary>
@property double StrikeRatioByMoney;

/// <summary>
/// 执行手续费
/// </summary>
@property double StrikeRatioByVolume;

@end
