//
//  PTFcpOptionDetail.h
//  OptionStrategy
//
//  Created by admin on 11/19/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

@interface PTFcpOptionDetail : NSObject

@property(readonly) NSString* InstrumentCode;
@property(readonly) PTFcpMarket market;

@property(readonly) NSString* Varieties;
@property(readonly) NSString* OptionMonth;

@property(readonly) NSString* UnderlyingInstrument;
@property(readonly) NSString* OptionTypeStr;

@property(readonly) double StrikePrice;


//
- (instancetype)initWithData:(NSString*)instrumentCode market:(PTFcpMarket) market;
-(PTFcpOptionsType) OptionType;
-(NSString*) InstrumentSerial;

+(int) getMonthIndex:(NSString*)instrumentCode;

@end
