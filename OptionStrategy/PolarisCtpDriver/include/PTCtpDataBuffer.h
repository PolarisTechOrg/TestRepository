//
//  PTCtpDataBuffer.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"
//#import "PTUserApiStruct.h"
#import "PTFcpInstrumentDetail.h"
#import "PTFcpEnums.h"
#import "Converter.h"
#import "PTFcpFund.h"
#import "PTFcpFundDetail.h"
#import "PTFcpFee.h"
#import "PTFcpMargin.h"
#import "PTFcpOrderBook.h"
#import "PTFcpTradeBook.h"
#import "PTFcpPosition.h"
#import "PTFcpPositionDetail.h"
#import "PTCtpOrderNum.h"
#import "PTCtpDriverCommonFunction.h"
#import "PTFcpMarketData.h"
#import "PTFcpInvestorBaseInfo.h"
#import "PTFcpVarieties.h"
#import "PTFcpOptionInstrCommRate.h"
#import "PTFcpOptionInstrTradeCost.h"

@interface PTCtpDataBuffer : NSObject

+(PTCtpDataBuffer*) shared;
- (instancetype)init;
-(void) updateInstrument:(PTFcpInstrumentDetail*) detail;
-(NSArray*) getInstruments;
-(NSArray*) getInstrumentDetails;
-(void) clear ;
-(PTFcpInstrument*) getInstrumentByCode:(NSString*) instrumentCode;
///获取合约乘数。
-(int) getVolumeMultipleByCode:(NSString*) instrumentCode ;
///获取合约乘数。
-(int) getVolumeMultiple:(PTFcpInstrument*) instrument;
///获取合约手续费
-(PTFcpFee*)getInstrumentFeeByCode:(NSString*) instrumentCode;
///获取合约手续费
-(PTFcpFee*)getInstrumentFee:(PTFcpInstrument*) instrument;
/// 获取合约保证金。
-(PTFcpMargin*) getInstrumentMarginByCode:(NSString*) instrumentCode;
/// 获取合约保证金(option)。
-(PTFcpOptionInstrTradeCost*) getOptionMarginByCode:(NSString*) instrumentCode;
/// 获取合约保证金。
-(PTFcpMargin*) getInstrumentMargin:(PTFcpInstrument*) instrument;
/// 帐户基本信息
-(PTFcpInvestorBaseInfo*) getInvestorInfo;
/////持仓信息
-(NSArray*)getPositions;
///持仓信息
-(NSArray*)getPositionDetails;
///成交单
-(NSArray*)getTradeBooks;
/// 品种
-(NSArray*) getOptionVarieties;
/// 品种
-(PTFcpVarieties*) getOptionVarieties:(NSString*)code;


-(void) updateMarketData:(PTFcpMarketData*) marketData;

//-(PTFcpFund*) CtpTradingAccountFieldToFcpFund:(PTCtpTradingAccountField) field;
//-(PTFcpFundDetail*) CtpTradingAccountFieldToFcpFundDetail:(PTCtpTradingAccountField) field;
//-(PTFcpPosition*) CtpInvestorPositonFieldToFcpPosition:(PTCtpInvestorPositionField) field;

/// <summary>
/// 获取合约手续费。
/// </summary>
/// <param name="instrument">合约。</param>
/// <returns>手续费信息。</returns>
-(PTFcpFee*) GetFee:(PTFcpInstrument*) instrument;
/// <summary>
/// 计算手续费。
/// </summary>
/// <param name="instrument"></param>
/// <param name="offsetType"></param>
/// <param name="qty"></param>
/// <param name="price"></param>
/// <returns></returns>
-(double) CalculateFee:(PTFcpInstrument*) instrument offsetType:(PTFcpOffsetType) offsetType  qty:(int) qty  price:(double) price;

// order add, cancel
-(PTFcpOrderBook*) CancelOrderFaild:(PTFcpOrderNum*) orderNum reason:(NSString*) reason;

// order book.
-(PTFcpOrderBook*) GetOrderBook:(PTFcpOrderNum*) orderNum;
-(PTFcpOrderBook*) GetCheckedOrderBook:(PTFcpOrderNum*) orderNum;

// all
/// <summary>
/// 获取全部委托单。
/// </summary>
-(NSArray*) GetOrderBooks;

/// <summary>
/// 更新委托回报。
/// </summary>
/// <param name="orderField">CTP委托回报。</param>
/// <returns>委托单号。</returns>
-(PTFcpOrderNum*) updateOrderBook:(PTFcpOrderBook*) orderBook;

-(void) updateTradeBook:(PTFcpTradeBook*) tradeBook;

/// <summary>
/// 更新合约手续费。
/// </summary>
/// <param name="field">CTP 手续费信息。</param>
-(void) updateInstrumentFee:(PTFcpFee*)fee;
/// <summary>
/// 更新合约保证金(Option)。
/// </summary>
/// <param name="field">CTP 保证金信息。</param>
-(void) updateOptionFee:(PTFcpOptionInstrCommRate*) fee;

/// <summary>
/// 更新合约保证金。
/// </summary>
/// <param name="field">CTP 保证金信息。</param>
-(void) updateInstrumentMargin:(PTFcpMargin*) margin;
/// <summary>
/// 更新合约保证金(option)。
/// </summary>
/// <param name="field">CTP 保证金信息。</param>
-(void) updateOptionMargin:(PTFcpOptionInstrTradeCost*) margin;

///获取合约手续费(option)
-(PTFcpOptionInstrCommRate*)getOptionFeeByCode:(NSString*) instrumentCode;

/// 帐户基本信息
-(void) updateInvestorInfo:(PTFcpInvestorBaseInfo *)info;
/////持仓信息
-(void) updatePosition:(PTFcpPosition*) position;
/////持仓信息
-(void) updatePositionDetail:(PTFcpPositionDetail*) detail;

// account
/// <summary>
/// 更新账户信息。
/// </summary>
/// <param name="field">CTP 账户资金信息。</param>
-(void)UpdateFundInfo:(PTFcpFundDetail*) detail;

///品种
-(void) updateOptionVarieties:(PTFcpVarieties*) varieties;

@end
