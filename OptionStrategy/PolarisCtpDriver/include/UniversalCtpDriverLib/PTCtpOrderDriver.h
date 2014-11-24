//
//  TestTraderspi.h
//  testctp02
//
//  Created by admin on 11/13/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PTUserApiStruct.h"
#import "PTSpiHandler.h"
#import "PTFcpEnums.h"
#import "PTFcpOrderBook.h"


@interface PTCtpOrderDriver : NSObject

@property NSString* brokerId;
@property id<PTCtpSpiHandlerDelegate> handler;
@property PTFcpOrderDriverState driverState;

@property int frontId;
@property int sessionId;

///注册回调接口, nil 可以清空回调接口。
-(void)RegisterHandler:(id<PTCtpSpiHandlerDelegate>) handler;

- (instancetype)initWithData:(NSString*)appPath brokerId:(NSString*)brokerId handler:(id<PTCtpSpiHandlerDelegate>)handler;

-(void) Connect:(NSString*) frontIp;
-(int) Login:(NSString*)brokerId userId:(NSString*)userId password:(NSString*) password;
-(void)updateMaxOrderRef:(int) maxOrderRef;
-(int) Logout ;
/// <summary>
/// 投资者结算结果确认。
/// </summary>
-(int)SettlementInfoConfirm :(NSError**)error;

/// <summary>
/// 委托下单。
/// </summary>
/// <param name="instrument">委托产品。</param>
/// <param name="qty">委托量。</param>
/// <param name="price">委托价格。</param>
/// <param name="offsetType">开平仓方向。</param>
/// <param name="orderSide">买卖方向。</param>
/// <param name="error">[out]委托失败原因。</param>
/// <returns>委托单号。</returns>
/// <remarks>返回为null代表失败,否则为委托单号。</remarks>
-(PTFcpOrderNum*) PlaceOrder:(PTFcpInstrument*) instrument qty:(int) qty price:(double)price  offsetType:(PTFcpOffsetType) offsetType  orderSide:(PTFcpOrderSide) orderSide error:(NSError**)error;
/// 撤单。
/// </summary>
/// <param name="orderNum">委托单号。</param>
/// <param name="product">委托产品。</param>
/// <param name="error">[out]撤单失败错误信息。</param>
/// <returns>撤单是否成功。</returns>
-(int) CancelOrder:(PTFcpOrderNum*) orderNum  product:(PTFcpInstrument*)product  error:(NSError**) error;

///请求查询报单
-(int)QryOrderBooks :(NSError**)error;
///请求查询成交
-(int)QryTradeBooks :(NSError**)error;
///请求查询投资者持仓
-(int)QryInvestorPosition :(NSError**)error;
///请求查询资金账户
-(void) QryTradingAccount:(NSError**)error;
///请求查询投资者
-(int)QryInvestor :(NSError**)error;
///请求查询合约保证金率
-(int)QryInstrumentMargin:(NSString*) instrumentCode error:(NSError**)error;
///请求查询合约手续费率
-(int)QryInstrumentFee:(NSString*) instrumentCode error:(NSError**)error;
///请求查询合约
-(int)QryInstruments :(NSError**)error;
///请求查询行情
-(int)QryDepthMarketData:(NSString*) instrumentCode error:(NSError**)error;
///请求查询投资者持仓明细
-(int)QryInvestorPositionDetail :(NSError**)error;


@end
