//
//  FAStrategyHoldingPositionDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyHoldingPositionDto.h"

@implementation FAStrategyHoldingPositionDto
// 合约代码。
@synthesize InstrumentCode;
// 持仓。
@synthesize OrderPosition;
// 持仓盈亏。
@synthesize HoldingProfit;
// 卖出总金额。
@synthesize SellAmount;
// 买入总金额。
@synthesize BuyAmount;
// 买入手续费。
@synthesize BuyFee;
// 卖出手续费。
@synthesize SellFee;
// 合约每点价值。
@synthesize VolumeMultiple;
@end
