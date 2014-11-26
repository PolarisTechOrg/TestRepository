//
//  PTFcpOrderBook.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpOrderNum.h"
#import "PTFcpInstrument.h"

@interface PTFcpOrderBook : NSObject<NSCopying>



/**
 * 委托单号。
 */
@property PTFcpOrderNum* OrderNum;

/**
 * 下单帐号。
 */
@property NSString* Account;

/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;


/**
 * 委托手数。
 */
@property int OrderQty;

/**
 * 委托价格。
 */
@property float OrderPrice;

/**
 * 成交手数。
 */
@property int TradeQty;

/**
 * 成交金额。
 */
@property float TradeAmount;

/**
 * 成交平均价。
 */
@property float TradePrice;

/**
 * 交易手续费。
 */
@property float TradeFee;

/**
 * 委托单状态。PTFcpOrderStatus
 */
@property PTFcpOrderStatus OrderStatus;

/**
 * 撤单量。
 */
@property int CancelQty;


/**
 * 买卖方向。FcpOrderSide
 */
@property PTFcpOrderSide OrderSide;

/**
 *  开平方向。FcpOffsetType
 */
@property PTFcpOffsetType OffsetType;

/**
 * 备注。
 */
@property NSString* Memo;

/**
 * 委托时间。
 */
@property NSDate* OrderTime;


//
/**
 * 合约代码。
 */
-(NSString*) InstrumentCode;
-(NSString*) InstrumentName;
-(PTFcpMarket) Market;
/**
 * 废单量。
 */
-(int) BlankQty;
/**
 * 委托单是否为结束。
 */
-(BOOL) IsFinish;
-(id)copyWithZone:(NSZone *)zone;

@end
