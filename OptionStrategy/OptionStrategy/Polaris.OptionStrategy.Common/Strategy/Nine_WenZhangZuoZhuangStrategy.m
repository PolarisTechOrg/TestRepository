//
//  Nine_WenZhangZuoZhuangStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Nine_WenZhangZuoZhuangStrategy.h"
#import "Nine_WenZhangZuoZhuangProfitPoint.h"
#import "OptionDetail.h"

@implementation Nine_WenZhangZuoZhuangStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Nine_WenZhangZuoZhuang;
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
    
    if(leftStrikePrice >= rightStrikePrice)
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
    
    if (leftOrder.OrderSide != FcpOrderSide_Buy || leftOption.OptionType != FcpOptionsType_Put)
    {
        errorMessage = @"左侧只能买入看跌期权";
        return NO;
    }
    if (rightOrder.OrderSide != FcpOrderSide_Sell || rightOption.OptionType != FcpOptionsType_Put)
    {
        errorMessage = @"右侧只能卖出看跌期权";
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
    
    if (leftOption.StrikePrice >= rightOption.StrikePrice)
    {
        errorMessage = @"卖出看跌期权行权价应大于买入看跌期权行权价";
        return NO;
    }
    
    if (leftOrder.OrderQty != rightOrder.OrderQty)
    {
        errorMessage = @"买入看跌期权下单手数必须同卖出看跌期权下单手数一致";
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
    
    double diffPrice = (rightOrder.OrderPrice - leftOrder.OrderPrice);
    double oneMaxProfit = diffPrice * volumeMultiple - oneFeeLeft - oneFeeRight;   // 最大盈利
    double oneMaxLoss = (rightOption.StrikePrice - leftOption.StrikePrice - diffPrice) * volumeMultiple + oneFeeLeft + oneFeeRight;     // 最大损失
    
    double equalPoint = rightOption.StrikePrice - diffPrice + (oneFeeLeft + oneFeeRight) / volumeMultiple; // 损益两平点
    
    double oneMarginRight = [self CalcOptionMargin:rightOrder.TradeCost Instrument: rightOrder.Instrument Royalty:rightOrder.OrderPrice * volumeMultiple];
    double oneLowAvaliableAmount = oneMarginRight + rightOrder.OrderPrice + leftOrder.OrderPrice + oneFeeLeft + oneFeeRight;
    double lowAvaliableAmount = oneLowAvaliableAmount * orderQty;
    
    Nine_WenZhangZuoZhuangProfitPoint *profitPoint = [[Nine_WenZhangZuoZhuangProfitPoint alloc] init];
    profitPoint.StrikePoint1 = strikePoint1;
    profitPoint.StrikePoint2 = strikePoint2;
    profitPoint.EqualPoint = equalPoint;
    
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
        item.Content = [NSString stringWithFormat:@"%@元", [self DoubleRound:oneMaxLoss * orderQty]];
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
        item.Title = @"帐户最低可动用余额：";
        item.Content = [NSString stringWithFormat:@"帐户最低可动用余额需在：%@元", [self DoubleRound:lowAvaliableAmount]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}

@end
