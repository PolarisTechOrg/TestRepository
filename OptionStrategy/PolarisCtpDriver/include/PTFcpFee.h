//
//  PTFcpFee.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

@interface PTFcpFee : NSObject<NSCopying>

/**
 * 合约。
 */
/// <summary>
/// 合约。
/// </summary>
@property PTFcpInstrument* Instrument;

/**
 * 开仓手续费率。
 */
@property double OpenRatioByMoney;

/**
 * 开仓手续费。
 */
@property double OpenRatioByVolume;

/**
 * 平仓手续费率。
 */
@property double CloseRatioByMoney;

/**
 * 平仓手续费。
 */
@property double CloseRatioByVolume;

/**
 * 平今仓手续费率。
 */
@property double CloseTodayRatioByMoney;

/**
 * 平今仓手续费。
 */
@property double CloseTodayRatioByVolume;

/**
 * 执行手续费率(期权特有)。
 */
@property double StrikeRatioByMoney;

/**
 * 执行手续费(期权特有)。
 */
@property double StrikeRatioByVolume;

@end
