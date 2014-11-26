//
//  PTFcpPositionDetail.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

@interface PTFcpPositionDetail : NSObject<NSCopying>

///成交编号
@property NSString* TradeID;

/**
 * 每笔建仓生成一个ID。
 */
@property int ID;

/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;

/**
 * 持仓多空方向。FcpDirection
 */
@property PTFcpDirection Direction;

/**
 * 持仓类型。FcpPositionType
 */
// @property PTFcpPositionType PositionType;


/**
 * 建仓数量(昨日仓为所有留仓数量)。
 */
@property int OpenQty;

/**
 * 建仓价格。 今日开仓为开仓价格，昨日开仓为昨日结算价。
 */
@property float OpenPrice;

/**
 * 开仓日期。
 */
@property NSDate* OpenDate;

///交易日
@property NSDate* TradingDay;

///数量
@property int Volume;
///昨结算价
@property double LastSettlementPrice;
///结算价
@property double SettlementPrice;

/**
 * 平仓量。
 */
@property int CloseQty;

/**
 * 平仓金额。
 */
@property float CloseAmount;

/**
 * 平仓平均价。
 */
@property float ClosePrice;


@end
