//
//  PTFcpMargin.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

@interface PTFcpMargin : NSObject<NSCopying>


/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;

/**
 * 交易所多头保证金率。
 */
@property float ExchangeLongMarginRatio;

/**
 * 交易所空头保证金率。
 */
@property float ExchangeShortMarginRatio;

/**
 * 期货公司多头保证金率。
 */
@property float BrokerLongMarginRatioByMoney;

/**
 * 期货公司多头保证金费。
 */
@property float BrokerLongMarginRatioByVolume;

/**
 * 期货公司空头保证金率。
 */
@property float BrokerShortMarginRatioByMoney;

/**
 * 期货公司空头保证金费。
 */
@property float BrokerShortMarginRatioByVolume;


@end
