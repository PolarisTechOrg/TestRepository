//
//  One_DaShengStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "One_DaShengStrategy.h"
#import "One_DaShengProfitPoint.h"
#import "OptionDetail.h"

@implementation One_DaShengStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_One_DaSheng;
}

/// <summary>
/// 校验组合行权价是否可用。
/// </summary>
/// <param name="leftStrikePrice">左侧行权价</param>
/// <param name="rightStrikePrice">右侧行权价</param>
/// <returns></returns>
- (BOOL)VerifyCombineStrikePrice:(NSNumber *)leftStrikePrice RightStrikePrice:(NSNumber *)rightStrikePrice
{
    if (rightStrikePrice)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/// <summary>
/// 校验策略委托是否合法。
/// </summary>
/// <param name="strategyOrder"></param>
/// <returns></returns>
- (BOOL)Verify:(CombineStrategyOrder*) strategyOrder Error:(out NSString *) errorMessage
{
    errorMessage = nil;
    if(strategyOrder.LeftOrder == nil || strategyOrder.RightOrder != nil)
    {
        errorMessage = @"委托单数量错误";
        return NO;
    }
    
    StrategyOrder *order = strategyOrder.LeftOrder;
    OptionDetail *option = [[OptionDetail alloc] Init:order.Instrument];
    if (option.OptionType != FcpOptionsType_Call || order.OrderSide != FcpOrderSide_Buy)
    {
        errorMessage = @"只能买入看涨期权";
        return NO;
    }
    
    if (order.OrderQty <= 0)
    {
        errorMessage = @"交易手数不能为0";
        return NO;
    }
    return YES;
}

/// <summary>
/// 计算期权策略损益明细。
/// </summary>
/// <param name="strategyOrder">委托信息。</param>
/// <returns></returns>
- (OptionStrategyDetail *)InternalCalcOptionStrategyDetail:(CombineStrategyOrder *)strategyOrder
{
    StrategyOrder *order = strategyOrder.LeftOrder;
    OptionDetail *option = [[OptionDetail alloc] Init:order.Instrument];
    
    int volumeMultiple = order.TradeCost.VolumeMultiple;
    double oneFee = order.TradeCost.FeeByVolume;
    double oneAmount = order.OrderPrice * volumeMultiple  + oneFee; // 单口成交金额
    double strikePoint = option.StrikePrice;
    double equalPoint = (oneAmount/volumeMultiple) + option.StrikePrice; // 损益两平点
    double totalAmount = oneAmount * order.OrderQty;
    
    One_DaShengProfitPoint *profitPoint = [[One_DaShengProfitPoint alloc] init];
    profitPoint.StrikePoint = strikePoint;
    profitPoint.EqualPoint = equalPoint;
    
    NSMutableArray *itemList = [NSMutableArray arrayWithCapacity:ARRAY_CAPACITY];
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 1;
        item.Title = @"最大可能获利：";
        item.Content = [NSString stringWithFormat:@"结算价大于%@点以上的无限获利空间", [self DoubleRound:profitPoint.EqualPoint]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 2;
        item.Title = @"最大可能亏损：";
        item.Content = [NSString stringWithFormat:@"损失权利金%@元", [self DoubleRound:totalAmount]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 3;
        item.Title = @"到期盈亏打和点：";
        item.Content = [NSString stringWithFormat:@"%@点，以上获利", [self DoubleRound:profitPoint.EqualPoint]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 4;
        item.Title = @"预计成交金额：";
        item.Content = [NSString stringWithFormat:@"(%@*%d+手续费%f)*%d手=%@元", [self DoubleRound:order.OrderPrice], volumeMultiple, oneFee, order.OrderQty, [self DoubleRound:totalAmount]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}
@end
