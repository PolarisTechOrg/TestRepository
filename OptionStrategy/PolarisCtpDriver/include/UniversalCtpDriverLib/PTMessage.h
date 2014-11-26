//
//  PTMessage.h
//  testctp02
//
//  Created by admin on 11/14/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int {
MSG_FRONT_SUCCESS = 0,// 连接前置成功
MSG_FRONT_DISCONNECT = 1,// 连接前置断开
    
MSG_LOGIN_SUCCESS = 2,// 登入成功
MSG_LOGIN_FAILURE = 3,// 登入失败
    
MSG_REQ_INSTRUMTN_DISPLAY = 4,
    
    /// 合约查询已经返回
MSG_REQ_INSTRUMENT_FINSH = 5,
    
MSG_REQ_ACCOUNT_DISPLAY = 6,
    
    // 资金查询已经返回
MSG_REQ_ACCOUNT_FINSH = 7,
    
MSG_REQ_POSITION_DISPLAY = 8,
MSG_REQ_POSITION_FINSH = 9,   // 持仓查询已经返回
    
MSG_REQ_POSITIONDETAIL_DISPLAY = 10,
MSG_REQ_POSITIONDETAIL_FINSH = 11,   // 持仓明细查询已经返回
    
MSG_ORDERINSERT_OK = 12,
MSG_ONRTNORDER = 13,
    
MSG_ERROR = 14,
    
MSG_SETTLEMENTCONFIRM = 15,
    
MSG_MARGINRATE = 16,
    
MSG_FEERATE = 17,
    
    ///成交通知
    MSG_ONRTNTRADE = 18,
    ///请求查询报单响应
    MSG_ONRSPQRYQRDER = 19,
    
MSG_ONRSPQRYTRADE = 20,
    
    ///请求查询行情响应
MSG_ONRSPQRYDEPTHMARKETDATA = 21,
    
MSG_LOGOUT_FINISH = 22,
    
MSG_ONRSPERR = 23,
    
MSG_ONRSPQRYINVESTOR = 24,
    ///报单操作请求响应
MSG_ONRSPORDERACTION = 25,
//MSG_OnRspOrderAction = 25,
    
MSG_OnErrRtnOrderAction = 26,
MSG_OnRspOrderInsert = 27,
    MSG_OnRspQryTradingAccount = 28,
    
// quote
    
//MSG_QUOTE_FRONT_DISCONNECT = 101,
    
//MSG_QUOTE_LOGIN_FINISH = 102,
    
MSG_QUOTE_ONRSP_SUBMARKETDATA = 105,
MSG_QUOTE_ONRSP_UNSUBMARKETDATA = 106,
MSG_QUOTE_OnRtnDepthMarketData = 107,
    
//MSG_QUOTE_LOGOUT_FINISH = 122,
    
//MSG_QUOTE_ONRSPERR = 123,
    
} PTMessageType;

@interface PTMessage : NSObject

@property int requestId;

@property(readonly) PTMessageType what;
@property  BOOL isFinished;
@property  BOOL isLast;
@property  id data;

@property int errorId;
@property NSString* message;

- (instancetype)initWithData:(PTMessageType)what isFinished:(int)isFinished isLast:(int)isLast data:(id)data;
- (instancetype)initWithData:(PTMessageType)what errorId:(int)errorId message:(NSString*)message isFinished:(int)isFinished isLast:(int)isLast data:(id)data;
- (instancetype)initWithData:(PTMessageType)what errorId:(int)errorId message:(NSString*)message isFinished:(int)isFinished isLast:(int)isLast data:(id)data requestId:(int)requestId;

@end
