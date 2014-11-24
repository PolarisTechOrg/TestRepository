//
//  PTFrozonOrder.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpInstrument.h"
#import "PTFcpOrderNum.h"
#import "PTFcpEnums.h"

@interface PTFcpFrozonOrder : NSObject

/// <summary>
/// 委托单号。
/// </summary>
@property PTFcpOrderNum* OrderNum;

/// <summary>
/// 合约。
/// </summary>
@property(readonly) PTFcpInstrument* Instrument;

/// <summary>
/// 冻结仓位方向。
/// </summary>
@property(readonly) PTFcpDirection Direction;

/// <summary>
/// 开平方向。
/// </summary>
@property(readonly) PTFcpOffsetType OffsetType;

/// <summary>
/// 平仓量。
/// </summary>
@property int CloseQty;

/// <summary>
/// 成交量。
/// </summary>
@property int TradeQty;

@property PTFcpOrderStatus OrderStatus;


- (instancetype)initWithData:(PTFcpOrderNum*)orderNum instrument:(PTFcpInstrument*)instrument direction:(PTFcpDirection)direction offsetType:(PTFcpOffsetType) offsetType;

@end
