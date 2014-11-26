//
//  PTFcpInstrumentDetail.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

@interface PTFcpInstrumentDetail : NSObject<NSCopying>

/**
 * 合约。
 */
@property PTFcpInstrument* Instrument;

/**
 * 创建日期。
 */
@property NSDate* OpenDate;

/// <summary>
/// 到期日。
/// </summary>
@property NSDate* ExpireDate;

/**
 * 交割日。
 */
@property NSDate* EndDelivDate;

/**
 * 合约乘数。
 */
@property int VolumeMultiple;

/**
 * 是否允许交易。
 */
@property BOOL IsTrading;

/**
 * 品种代码。
 */
@property NSString* Varieties;

/**
 * 交易所多头保证金率。
 */
@property double ExchangeLongMarginRatio;

/**
 * 交易所空头保证金率。
 */
@property double ExchangeShortMarginRatio;

/**
 * 产品类型。FcpProductClass
 */
@property int ProductClass;

/**
 * 基础商品代码。
 */
@property NSString* UnderlyingInstrument;

/**
 * 期权执行价。
 */
@property float StrikePrice;

/**
 * 期权类型。FcpOptionsType
 */
@property int OptionsType;

/**
 * 合约系列。
 */
@property NSString* InstrumentSerial;

/**
 * 最小变动价位。
 */
@property double PriceTick;

@end
