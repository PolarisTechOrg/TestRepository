//
//  PTFcpDepthMarketData.h
//  OptionStrategy
//
//  Created by admin on 11/18/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"

/// <summary>
/// 深度行情
/// </summary>
@interface PTFcpMarketData : NSObject

@property PTFcpInstrument* Instrument;

/// <summary>
/// 交易日			char[9]
/// </summary>
@property NSString* TradingDayString;
@property NSDate* UpdateTime;

/// <summary>
/// 合约代码			char[31]
/// </summary>
@property NSString* InstrumentID;

/// <summary>
/// 交易所代码		char[9]
/// </summary>
@property NSString* ExchangeID;

/// <summary>
/// 合约在交易所的代码char[31]
/// </summary>
@property NSString* ExchangeInstID;

/// <summary>
/// 最新价			double
/// </summary>
@property double LastPrice;

/// <summary>
/// 上次结算价		double
/// </summary>
@property double PreSettlementPrice;

/// <summary>
/// 昨收盘			double
/// </summary>
@property double PreClosePrice;

/// <summary>
/// 昨持仓量			double
/// </summary>
@property double PreOpenInterest;

/// <summary>
/// 今开盘			double
/// </summary>
@property double OpenPrice;

/// <summary>
/// 最高价			double
/// </summary>
@property double HighestPrice;

/// <summary>
/// 最低价			double
/// </summary>
@property double LowestPrice;

/// <summary>
/// 数量				int
/// </summary>
@property int Volume;

/// <summary>
/// 成交金额			double
/// </summary>
@property double Turnover;

/// <summary>
/// 持仓量			double
/// </summary>
@property double OpenInterest;

/// <summary>
/// 今收盘			double
/// </summary>
@property double ClosePrice;

/// <summary>
/// 本次结算价		double
/// </summary>
@property double SettlementPrice;

/// <summary>
/// 涨停板价			double
/// </summary>
@property double UpperLimitPrice;

/// <summary>
/// 跌停板价			double
/// </summary>
@property double LowerLimitPrice;

/// <summary>
/// 昨虚实度			double
/// </summary>
@property double PreDelta;

/// <summary>
/// 今虚实度			double
/// </summary>
@property double CurrDelta;

/// <summary>
/// 最后修改时间		char[9]
/// </summary>
@property NSString* UpdateTimeString;

/// <summary>
/// 最后修改毫秒		int
/// </summary>
@property int UpdateMillisec;

/// <summary>
/// 申买价一			double
/// </summary>
@property double BidPrice1;

/// <summary>
/// 申买量一			int
/// </summary>
@property int BidVolume1;

/// <summary>
/// 申卖价一			double
/// </summary>
@property double AskPrice1;

/// <summary>
/// 申卖量一			int
/// </summary>
@property int AskVolume1;

/// <summary>
/// 申买价二			double
/// </summary>
@property double BidPrice2;

/// <summary>
/// 申买量二			int
/// </summary>
@property int BidVolume2;

/// <summary>
/// 申卖价二			double
/// </summary>
@property double AskPrice2;

/// <summary>
/// 申卖量二			int
/// </summary>
@property int AskVolume2;

/// <summary>
/// 申买价三			double
/// </summary>
@property double BidPrice3;

/// <summary>
/// 申买量三			int
/// </summary>
@property int BidVolume3;

/// <summary>
/// 申卖价三			double
/// </summary>
@property double AskPrice3;

/// <summary>
/// 申卖量三			int
/// </summary>
@property int AskVolume3;

/// <summary>
/// 申买价四			double
/// </summary>
@property double BidPrice4;

/// <summary>
/// 申买量四			int
/// </summary>
@property int BidVolume4;

/// <summary>
/// 申卖价四			double
/// </summary>
@property double AskPrice4;

/// <summary>
/// 申卖量四			int
/// </summary>
@property int AskVolume4;

/// <summary>
/// 申买价五			double
/// </summary>
@property double BidPrice5;

/// <summary>
/// 申买量五			int
/// </summary>
@property int BidVolume5;

/// <summary>
/// 申卖价五			double
/// </summary>
@property double AskPrice5;

/// <summary>
/// 申卖量五			int
/// </summary>
@property int AskVolume5;

/// <summary>
/// 当日均价			double
/// </summary>
@property double AveragePrice;

///业务日期
@property NSString* ActionDay;

@end
