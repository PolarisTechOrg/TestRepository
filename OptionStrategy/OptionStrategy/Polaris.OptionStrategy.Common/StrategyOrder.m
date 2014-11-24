//
//  StrategyOrder.m
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import "StrategyOrder.h"

@implementation StrategyOrder

/// <summary>
/// 合约代码。
/// </summary>
@synthesize Instrument;

/// <summary>
/// 买卖方向。
/// </summary>
@synthesize OrderSide;

/// <summary>
/// 下单价格。
/// </summary>
@synthesize OrderPrice;

/// <summary>
/// 下单量。
/// </summary>
@synthesize OrderQty;

/// <summary>
/// 交易成本信息。
/// </summary>
@synthesize TradeCost;

@end
