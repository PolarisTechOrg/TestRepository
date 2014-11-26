//
//  PTOptionTPriceItemViewModel.h
//  OptionStrategy
//
//  Created by admin on 11/26/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTOptionTPriceItemViewModel : NSObject

///履约价格
@property int strikePrice;
@property NSDate* expireDate;

/// 合约代码
@property NSString* cInstrumentCode;

/// <summary>
/// 申卖价一			double
/// </summary>
@property double cAskPrice1;
/// <summary>
/// 申买价一			double
/// </summary>
@property double cBidPrice1;

///波动率
@property double cVolatility;

/// 合约代码
@property NSString* pInstrumentCode;

/// <summary>
/// 申卖价一			double
/// </summary>
@property double bAskPrice1;
/// <summary>
/// 申买价一			double
/// </summary>
@property double bBidPrice1;

///波动率
@property double bVolatility;



@end
