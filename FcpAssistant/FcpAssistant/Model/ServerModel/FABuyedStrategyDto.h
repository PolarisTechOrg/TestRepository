//
//  FABuyedStrategyDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FABuyedStrategyDto : NSObject

// 组合策略ID。
@property(nonatomic,assign) int CombineStrategyId;
/// 组合策略名称。
@property(nonatomic,copy) NSString *CombineStrategyName;
/// 策略ID。
@property(nonatomic,assign) int StrategyId;
/// 策略名称。
@property(nonatomic,copy) NSString *StrategyName;
/// 标的名称。
@property(nonatomic,copy) NSString *UnderName;
// 策略品种列表。
@property(nonatomic,retain) NSArray *Underlyings;
// 订购时间。
@property(nonatomic,retain) NSDate *BuyedTime;
/// 星级。
@property(nonatomic,assign) double Star;
// 跟单倍数。
@property(nonatomic,assign) int BuyedQuantity;
// 策略盈亏。
@property(nonatomic,assign) double StrategyProfit;
// 今日盈亏。
@property(nonatomic,assign) double TodayProfit;
// 昨日盈亏。
@property(nonatomic,assign) double YesterdayProfit;
//是否有持仓
@property(nonatomic,assign) BOOL HasPosition;
//今日信号条数
@property(nonatomic,assign) int TodaySignalCount;
//策略品种数据集合类型
+(Class) Underlyings_class;
@end
