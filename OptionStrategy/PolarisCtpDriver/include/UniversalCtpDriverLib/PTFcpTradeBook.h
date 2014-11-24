//
//  PTFcpTradeBook.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpOrderNum.h"
#import "PTFcpInstrument.h"

@interface PTFcpTradeBook : NSObject<NSCopying>


/**
 * 成交编号
 */
@property NSString* TradeNum;

/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;


/**
 * 委托单号
 */
@property PTFcpOrderNum* OrderNum;

/**
 * 买卖方向。FcpOrderSide
 */
@property PTFcpOrderSide OrderSide;

/**
 * 开平标志。FcpOffsetType
 */
@property PTFcpOffsetType OffsetType;

/**
 * 成交价格
 */
@property float Price;

/**
 * 成交数量
 */
@property int Qty;

/**
 * 成交金额(成交金额 = 成交价格 * 成交量 * 每点价值
 */
@property float Amount;

/**
 * 手续费
 */
@property float Fee;

/**
 * 成交时间
 */
@property NSDate* TradeTime;

@property NSString* Account;

@end
