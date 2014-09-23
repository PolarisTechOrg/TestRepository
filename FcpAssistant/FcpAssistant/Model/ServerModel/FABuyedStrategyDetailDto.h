//
//  FABuyedStrategyDetailDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FABuyedStrategyDto.h"
#import "FAStrategyHoldingPositionDto.h"
#import "FAStrategySignalDto.h"
#import "FAStrategyOrderBookDto.h"
#import "FAStrategyProfitDto.h"

@interface FABuyedStrategyDetailDto : NSObject

// 策略信息。
@property(nonatomic,retain) FABuyedStrategyDto *Strategy;
// 策略持仓信息。
@property(nonatomic,retain) NSArray *HoldingPositionList;
// 策略信号信息。
@property(nonatomic,retain) NSArray *SignalList;
/// 委托记录信息。
@property(nonatomic,retain) NSArray *OrderBookList;
/// 历史绩效信息。
@property(nonatomic,retain) NSArray *HistoryProfitList;

//策略持仓数据集合类型
+(Class) HoldingPositionList_class;
//策略信号数据集合类型
+(Class) SignalList_class;
//委托记录数据集合类型
+(Class) OrderBookList_class;
//历史绩效信息数据集合类型
+(Class) HistoryProfitList_class;
@end
