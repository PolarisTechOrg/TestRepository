//
//  PTFcpOptionInstrTradeCost.h
//  PolarisCtpDriver
//
//  Created by admin on 11/24/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

/// 期权交易成本(保证金)
@interface PTFcpOptionInstrTradeCost : NSObject


/// <summary>
/// 经纪公司代码
/// </summary>
@property NSString* BrokerID;

/// <summary>
/// 投资者代码				char 13
/// </summary>
@property NSString* InvestorID;

/// <summary>
/// 合约代码
/// </summary>
@property NSString* InstrumentID;

/// <summary>
/// 投机套保标志 HedgeFlagType
/// </summary>
@property PTFcpHedgeFlagType HedgeFlag;

/// <summary>
/// 期权合约保证金不变部分
/// </summary>
@property double FixedMargin;

/// <summary>
/// 期权合约最小保证金
/// </summary>
@property double MiniMargin;

/// <summary>
/// 期权合约权利金
/// </summary>
@property double Royalty;

/// <summary>
/// 交易所期权合约保证金不变部分
/// </summary>
@property double ExchFixedMargin;

/// <summary>
/// 交易所期权合约最小保证金
/// </summary>
@property double ExchMiniMargin;

@end
