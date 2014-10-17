//
//  FAStrategyOrderBookDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategyOrderBookDto : NSObject
// 组合策略ID。
@property(nonatomic,assign) int CombineStragetyID;
// 策略ID。
@property(nonatomic,assign) int StragetyID;
// 合约代码。
@property(nonatomic,copy) NSString *InstrumentCode;
// 委托口数。
@property(nonatomic,assign) int OrderQty;
// 成交口数。
@property(nonatomic,assign) int TradeQty;
// 成交价格。
@property(nonatomic,assign) double TradePrice;
// 委托时间。
@property(nonatomic,copy) NSDate *OrderTime;
// 委托状态
@property(nonatomic,assign) int OrderStatus;
@end
