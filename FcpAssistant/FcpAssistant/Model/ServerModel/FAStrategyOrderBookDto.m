//
//  FAStrategyOrderBookDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyOrderBookDto.h"

@implementation FAStrategyOrderBookDto
// 组合策略ID。
@synthesize CombineStragetyID;
// 策略ID。
@synthesize StragetyID;
// 合约代码。
@synthesize InstrumentCode;
// 委托口数。
@synthesize OrderQty;
// 成交口数。
@synthesize TradeQty;
// 成交价格。
@synthesize TradePrice;
// 委托时间。
@synthesize OrderTime;
@end
