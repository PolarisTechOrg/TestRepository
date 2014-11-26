//
//  PTStrategyService.h
//  PolarisCtpDriver
//
//  Created by admin on 11/24/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

@interface PTStrategyService : NSObject

/// <summary>
/// 获取所有期权品种。
/// </summary>
/// <returns></returns>
/// <remarks>
/// GET api/Instrument?varieties
/// </remarks>
+(NSArray*) getOptionVarieties;
/// [OptionInstrument]
+(NSArray*) getOptionInstruments;
/// [OptionInstrument]
+(NSArray*) getOptionInstruments:(NSString*) varieties;

+(PTFcpMarket) ExchangeToFcpMarket:(NSString*) exchange;
+(NSString*) FcpMarketToExchange:(PTFcpMarket) market;

@end
