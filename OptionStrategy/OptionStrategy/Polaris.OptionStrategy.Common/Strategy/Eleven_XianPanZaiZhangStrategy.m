//
//  Eleven_XianPanZaiZhangStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Eleven_XianPanZaiZhangStrategy.h"
#import "Eleven_XianPanZaiZhangProfitPoint.h"
#import "OptionDetail.h"

@implementation Eleven_XianPanZaiZhangStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Eleven_XianPanZaiZhang;
}

/// <summary>
/// 校验组合行权价是否可用。
/// </summary>
/// <param name="leftStrikePrice">左侧行权价</param>
/// <param name="rightStrikePrice">右侧行权价</param>
/// <returns></returns>
- (BOOL)VerifyCombineStrikePrice:(NSNumber *)leftStrikePrice RightStrikePrice:(NSNumber *)rightStrikePrice
{
    if (rightStrikePrice == nil)
    {
        return NO;
    }
    
    if(leftStrikePrice != rightStrikePrice)
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
    if(strategyOrder.LeftOrder == nil || strategyOrder.RightOrder == nil)
    {
        errorMessage = @"委托单数量错误";
        return NO;
    }
    
    StrategyOrder *leftOrder = strategyOrder.LeftOrder;
    StrategyOrder *rightOrder = strategyOrder.RightOrder;
    OptionDetail *leftOption = [[OptionDetail alloc] Init:leftOrder.Instrument];
    OptionDetail *rightOption = [[OptionDetail alloc] Init:rightOrder.Instrument];
    
    if (leftOrder.OrderSide != FcpOrderSide_Sell || leftOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"左侧只能卖出看涨期权";
        return NO;
    }
    if (rightOrder.OrderSide != FcpOrderSide_Buy || rightOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"右侧只能买入看涨期权";
        return NO;
    }
    
    if (leftOrder.OrderQty <= 0 || rightOrder.OrderQty <= 0)
    {
        errorMessage = @"交易手数不能为0";
        return NO;
    }
    
    if (leftOption.InstrumentSerial != rightOption.InstrumentSerial)
    {
        errorMessage = @"合约系列必须一致";
        return NO;
    }
    
    if (leftOption.StrikePrice != rightOption.StrikePrice)
    {
        errorMessage = @"买入看涨期权行权价应等于卖出看涨期权行权价";
        return NO;
    }
    
    if (leftOrder.OrderQty != rightOrder.OrderQty)
    {
        errorMessage = @"买入看涨期权下单手数必须同卖出看涨期权下单手数一致";
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
    StrategyOrder *leftOrder = strategyOrder.LeftOrder;
    StrategyOrder *rightOrder = strategyOrder.RightOrder;
    OptionDetail *leftOption = [[OptionDetail alloc] Init:leftOrder.Instrument];
    OptionDetail *rightOption = [[OptionDetail alloc] Init:rightOrder.Instrument];
    
    int volumeMultiple = leftOrder.TradeCost.VolumeMultiple;
    int orderQty = leftOrder.OrderQty;
    
    double oneFeeLeft = leftOrder.TradeCost.FeeByVolume;
    double oneFeeRight = rightOrder.TradeCost.FeeByVolume;
    double strikePoint = leftOption.StrikePrice;
    
    double oneMaxProfit = leftOrder.OrderPrice * volumeMultiple - oneFeeLeft - oneFeeRight;   // 最大盈利
    double diffPrice = (rightOrder.OrderPrice - leftOrder.OrderPrice);
    double onePreAmount = (diffPrice * volumeMultiple) + oneFeeLeft + oneFeeRight; // 预估成交金额
    
    Eleven_XianPanZaiZhangProfitPoint *profitPoint = [[Eleven_XianPanZaiZhangProfitPoint alloc] init];
    profitPoint.StrikePoint = strikePoint;
    
    NSMutableArray *itemList = [NSMutableArray arrayWithCapacity:ARRAY_CAPACITY];
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 1;
        item.Title = @"最大可能获利：";
        item.Content = [NSString stringWithFormat:@"可收取的权利金%@元", [self DoubleRound:oneMaxProfit * orderQty]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 2;
        item.Title = @"最大可能亏损：";
        item.Content = @"行情走势先涨再盘";
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 3;
        item.Title = @"到期盈亏打和点：";
        item.Content = @"需视波动率而定";
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 4;
        item.Title = @"预计成交金额：";
        item.Content = [NSString stringWithFormat:@"(%@*%@+手续费%@)*%@ = %@元", [self DoubleRound:diffPrice], [self DoubleRound:volumeMultiple], [self DoubleRound:oneFeeLeft + oneFeeRight], [self DoubleRound:orderQty], [self DoubleRound:onePreAmount * orderQty]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}
@end
