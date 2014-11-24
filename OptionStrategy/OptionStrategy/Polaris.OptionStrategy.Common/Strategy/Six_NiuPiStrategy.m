//
//  Six_NiuPiStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Six_NiuPiStrategy.h"
#import "Six_NiuPiProfitPoint.h"
#import "OptionDetail.h"

@implementation Six_NiuPiStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Six_NiuPi;
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
    
    if(leftStrikePrice < rightStrikePrice)
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
    
    if (leftOrder.OrderSide != FcpOrderSide_Sell || rightOrder.OrderSide != FcpOrderSide_Sell)
    {
        errorMessage = @"只能卖出期权";
        return NO;
    }
    
    if (leftOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"左侧必须卖出看涨期权";
        return NO;
    }
    if (rightOption.OptionType != FcpOptionsType_Put)
    {
        errorMessage = @"右侧必须卖出看跌期权";
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
    
    if (leftOption.StrikePrice < rightOption.StrikePrice)
    {
        errorMessage = @"看涨期权行权价应大于等于看跌期权行权价";
        return NO;
    }
    
    if (leftOrder.OrderQty != rightOrder.OrderQty)
    {
        errorMessage = @"看涨期权下单手数必须同看跌期权下单手数一致";
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
    double strikePoint1 = rightOption.StrikePrice;
    double strikePoint2 = leftOption.StrikePrice;
    
    double oneMaxProfitLeft = leftOrder.OrderPrice * volumeMultiple - oneFeeLeft;
    double oneMaxProfitRight = rightOrder.OrderPrice * volumeMultiple - oneFeeRight;
    double oneMaxProfit = oneMaxProfitLeft + oneMaxProfitRight;
    
    double equalPoint1 = rightOption.StrikePrice - (leftOrder.OrderPrice + rightOrder.OrderPrice) + (oneFeeLeft + oneFeeRight) / volumeMultiple; // 下方损益两平点
    double equalPoint2 = leftOption.StrikePrice + (leftOrder.OrderPrice + rightOrder.OrderPrice) - (oneFeeLeft + oneFeeRight) / volumeMultiple; // 上方损益两平点
    
    double oneMarginLeft = [self CalcOptionMargin:leftOrder.TradeCost Instrument:leftOrder.Instrument Royalty:leftOrder.OrderPrice * volumeMultiple];
    double lowAvaliableAmountLeft = (oneMarginLeft + oneFeeLeft) * orderQty;
    double oneMarginRight = [self CalcOptionMargin:rightOrder.TradeCost Instrument:rightOrder.Instrument Royalty:rightOrder.OrderPrice * volumeMultiple];
    double lowAvaliableAmountRight = (oneMarginRight + oneFeeRight) * orderQty;
    double lowAvaliableAmount = lowAvaliableAmountLeft + lowAvaliableAmountRight;
    
    Six_NiuPiProfitPoint *profitPoint = [[Six_NiuPiProfitPoint alloc] init];
    profitPoint.StrikePoint1 = strikePoint1;
    profitPoint.StrikePoint2 = strikePoint2;
    profitPoint.EqualPoint1 = equalPoint1;
    profitPoint.EqualPoint2 = equalPoint2;
    
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
        item.Content = @"最大风险损失无限";
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 3;
        item.Title = @"到期盈亏打和点：";
        item.Content = [NSString stringWithFormat:@"上方：%@点，以下获利\r\n下方：%@点，以上获利", [self DoubleRound:profitPoint.EqualPoint2], [self DoubleRound:profitPoint.EqualPoint1]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 4;
        item.Title = @"帐户最低可动用余额：";
        item.Content = [NSString stringWithFormat:@"帐户最低可动用余额需在%@元", [self DoubleRound:lowAvaliableAmount]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}

@end
