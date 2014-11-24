//
//  OptionDetail.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "FcpMarket.h"
#import "FcpOptionsType.h"
#import "FcpInstrument.h"

@interface OptionDetail : NSObject

- (OptionDetail *)Init:(FcpInstrument *)instrument;

- (OptionDetail *)Init:(NSString *)instrumentCode Market:(FcpMarket)market;


@property (nonatomic, copy) NSString *InstrumentCode;

@property (nonatomic, copy) NSString *Varieties;

@property (nonatomic, assign) FcpMarket Market;

@property (nonatomic, copy) NSString *OptionMonth;

@property (nonatomic, copy) NSString *ExchangeOptionMonth;

@property (getter=getInstrumentSerial, copy) NSString *InstrumentSerial;

@property (nonatomic, copy) NSString *UnderlyingInstrument;

@property (getter=getOptionType, assign) FcpOptionsType OptionType;

@property (nonatomic, copy) NSString *OptionTypeStr;

@property (nonatomic, assign) int StrikePrice;

@end
