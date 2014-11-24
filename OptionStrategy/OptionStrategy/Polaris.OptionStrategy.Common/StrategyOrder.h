//
//  StrategyOrder.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "FcpInstrument.h"
#import "FcpOrderSide.h"
#import "OptionTradeCost.h"

@interface StrategyOrder : NSObject

/// <summary>
/// 合约代码。
/// </summary>
@property (nonatomic, retain) FcpInstrument *Instrument;

/// <summary>
/// 买卖方向。
/// </summary>
@property (nonatomic, assign) FcpOrderSide OrderSide;

/// <summary>
/// 下单价格。
/// </summary>
@property (nonatomic, assign) double OrderPrice;

/// <summary>
/// 下单量。
/// </summary>
@property (nonatomic, assign) int OrderQty;

/// <summary>
/// 交易成本信息。
/// </summary>
@property (nonatomic, retain) OptionTradeCost *TradeCost;

@end
