//
//  PTFcpPosition.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

@interface PTFcpPosition : NSObject<NSCopying>

/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;

/**
 * 持仓多空方向。FcpDirection。
 */
@property PTFcpDirection Direction;

///今日持仓
@property int Position;
///持仓成本
@property double PositionCost;
///平仓盈亏
@property double CloseProfit;
///持仓盈亏
@property double PositionProfit;


/**
 * 今日新仓量(实际持仓)。
 */
@property int NewPosition;

/**
 * 昨仓量(实际持仓)。
 */
@property int OldPosition;

/**
 * 今日新仓冻结量(平仓指令成交前)。
 */
@property int NewFrozonPosition;


/**
 * 昨仓冻结量(平仓指令成交前)。
 */
@property int OldFrozonPosition;


/**
 * 昨日持仓量(昨日结算后的持仓,当日不变)。
 */
@property int YesterdayPosition;


/**
 * 持仓均价。
 */
@property float AvgPirce;

/**
 * 持仓金额。
 */
@property float Amount;

/**
 * 开仓量。
 */
@property int OpenQty;

/**
 * 平仓量。
 */
@property int CloseQty;


@end
