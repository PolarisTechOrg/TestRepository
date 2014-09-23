//
//  FABuyedStrategyDetailDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FABuyedStrategyDetailDto.h"

@implementation FABuyedStrategyDetailDto
// 策略信息。
@synthesize Strategy;
// 策略持仓信息。
@synthesize HoldingPositionList;
// 策略信号信息。
@synthesize SignalList;
// 委托记录信息。
@synthesize OrderBookList;
// 历史绩效信息。
@synthesize HistoryProfitList;

//策略持仓数据集合类型
+(Class) HoldingPositionList_class
{
    return [FAStrategyHoldingPositionDto class];
}

//策略信号数据集合类型
+(Class) SignalList_class
{
    return [FAStrategySignalDto class];
}

//委托记录数据集合类型
+(Class) OrderBookList_class
{
    return [FAStrategyOrderBookDto class];
}

//历史绩效信息数据集合类型
+(Class) HistoryProfitList_class
{
    return [FAStrategyProfitDto class];
}

@end
