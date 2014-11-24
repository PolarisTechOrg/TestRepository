//
//  Seven_WenZhangStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Seven_WenZhangStrategy.h"
#import "Seven_WenZhangProfitPoint.h"
#import "OptionDetail.h"

@implementation Seven_WenZhangStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Seven_WenZhang;
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
    
    if (leftOrder.OrderSide != FcpOrderSide_Buy || leftOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"左侧只能买入看涨期权";
        return NO;
    }
    if (rightOrder.OrderSide != FcpOrderSide_Sell || rightOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"右侧只能卖出看涨期权";
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
        errorMessage = @"卖出看涨期权行权价应大于买入看涨期权行权价";
        return NO;
    }
    
    if (leftOrder.OrderQty != rightOrder.OrderQty)
    {
        errorMessage = @"买入看涨期权下单手数必须同卖出看跌期权下单手数一致";
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
    
    double diffPrice =  (leftOrder.OrderPrice - rightOrder.OrderPrice);
    double oneMaxProfit = (rightOption.StrikePrice - leftOption.StrikePrice - diffPrice) * volumeMultiple - oneFeeLeft - oneFeeRight;   // 最大盈利
    double oneMaxLoss = diffPrice * volumeMultiple + oneFeeLeft + oneFeeRight;     // 最大损失
    
    double equalPoint = leftOption.StrikePrice + diffPrice + (oneFeeLeft + oneFeeRight) / volumeMultiple; // 损益两平点
    double onePreAmount = (diffPrice * volumeMultiple) + oneFeeLeft + oneFeeRight; // 预估成交金额
    
    Seven_WenZhangProfitPoint *profitPoint = [[Seven_WenZhangProfitPoint alloc] init];
    profitPoint.StrikePoint1 = strikePoint1;
    profitPoint.StrikePoint2 = strikePoint2;
    profitPoint.EqualPoint = equalPoint;
    
    NSMutableArray *itemList = [NSMutableArray arrayWithCapacity:ARRAY_CAPACITY];
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 1;
        item.Title = @"最大可能获利：";
        item.Content = [NSString stringWithFormat:@"%@元，结算指数(价)在%f点以上", [self DoubleRound:oneMaxProfit * orderQty], profitPoint.StrikePoint2];  //[SH]
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 2;
        item.Title = @"最大可能亏损：";
        item.Content = [NSString stringWithFormat:@"%@元，结算指数(价)在%f点以下", [self DoubleRound:oneMaxLoss * orderQty], profitPoint.StrikePoint1];
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
        item.Content = [NSString stringWithFormat:@"(%@*%@+手续费%@)*%@ = %@元", [self DoubleRound:diffPrice], [self DoubleRound:volumeMultiple], [self DoubleRound:oneFeeLeft + oneFeeRight], [self DoubleRound:orderQty], [self DoubleRound:onePreAmount * orderQty]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}

@end
