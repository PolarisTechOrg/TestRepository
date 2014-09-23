//
//  FAStrategyHoldingPositionDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategyHoldingPositionDto : NSObject
// 合约代码。
@property(nonatomic,copy) NSString *InstrumentCode;
// 持仓。
@property(nonatomic,assign) int OrderPosition;
// 持仓盈亏。
@property(nonatomic,assign) double HoldingProfit;
// 卖出总金额。
@property(nonatomic,assign) double SellAmount;
// 买入总金额。
@property(nonatomic,assign) double BuyAmount;
// 买入手续费。
@property(nonatomic,assign) double BuyFee;
// 卖出手续费。
@property(nonatomic,assign) double SellFee;
// 合约每点价值。
@property(nonatomic,assign) int VolumeMultiple;
@end
