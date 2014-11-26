//
//  PTCtpOrderNum.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpOrderNum.h"

@interface PTCtpOrderNum : PTFcpOrderNum


/// <summary>
/// 鍓嶇疆缂栧彿銆�
/// </summary>
@property int FrontID;


/// <summary>
/// 浼氳瘽缂栧彿銆�
/// </summary>
@property int SessionID;


/// <summary>
/// 鎶ュ崟寮曠敤銆�
/// </summary>
@property NSString* OrderRef;


/// <summary>
/// 浜ゆ槗鎵�唬鐮併�
/// </summary>
@property NSString* ExchangeID;


/// <summary>
/// 鎶ュ崟缂栧彿銆�
/// </summary>
@property NSString* OrderSysID;

// functin
- (instancetype)initWithOrderRef:(int) frontID sessionID:(int) sessionID orderRef:(NSString*) orderRef exchangeID:(NSString*) exchangeID orderSysID:(NSString*) orderSysID;
- (instancetype)initWithExchange:(NSString*) exchangeID orderSysID:(NSString*) orderSysID;
-(NSString*) getOrderString;
-(BOOL)isEqual:(id)object;
-(BOOL)isEqualToCtpOrderNum:(PTCtpOrderNum*)object;
-(NSString*) description;
-(id)copyWithZone:(NSZone *)zone;

@end
