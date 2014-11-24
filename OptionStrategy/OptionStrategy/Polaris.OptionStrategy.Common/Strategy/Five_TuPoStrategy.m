//
//  Five_TuPoStrategy.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "Five_TuPoStrategy.h"
#import "Five_TuPoProfitPoint.h"
#import "OptionDetail.h"

@implementation Five_TuPoStrategy

/// <summary>
/// 策略类型。
/// </summary>
- (OptionStrategyType)getStrategyType
{
    return OptionStrategyType_Five_TuPo;
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
    
    if (leftOrder.OrderSide != FcpOrderSide_Buy || rightOrder.OrderSide != FcpOrderSide_Buy)
    {
        errorMessage = @"只能买入期权";
        return NO;
    }
    
    if (leftOption.OptionType != FcpOptionsType_Call)
    {
        errorMessage = @"左侧必须买入看涨期权";
        return NO;
    }
    if (rightOption.OptionType != FcpOptionsType_Put)
    {
        errorMessage = @"右侧必须买入看跌期权";
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
    
    double oneAmountLeft = leftOrder.OrderPrice * volumeMultiple + oneFeeLeft;    // 左侧单口成交金额
    double oneAmountRight = rightOrder.OrderPrice * volumeMultiple + oneFeeRight; // 右侧单口成交金额
    double oneAmount = oneAmountLeft + oneAmountRight;
    double totalAmount = oneAmount * orderQty;
    
    double equalPoint1 = strikePoint1 - (oneAmount / volumeMultiple); // 损益两平点(下方)
    double equalPoint2 = (oneAmount / volumeMultiple) + strikePoint2; // 损益两平点(上方)
    
    Five_TuPoProfitPoint *profitPoint = [[Five_TuPoProfitPoint alloc] init];
    profitPoint.StrikePoint1 = strikePoint1;
    profitPoint.StrikePoint2 = strikePoint2;
    profitPoint.EqualPoint1 = equalPoint1;
    profitPoint.EqualPoint2 = equalPoint2;
    
    NSMutableArray *itemList = [NSMutableArray arrayWithCapacity:ARRAY_CAPACITY];
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 1;
        item.Title = @"最大可能获利：";
        item.Content = @"无上限，结算价若离选定的行使价越远，获利越大";
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 2;
        item.Title = @"最大可能亏损：";
        item.Content = [NSString stringWithFormat:@"损失期权金%@元", [self DoubleRound:oneAmount * orderQty]];
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 3;
        item.Title = @"到期盈亏打和点：";
        item.Content = [NSString stringWithFormat:@"上方：%@点，以上获利\r\n下方：%@点，以下获利", [self DoubleRound:profitPoint.EqualPoint2], [self DoubleRound:profitPoint.EqualPoint2]];   //[SH]
        [itemList addObject:item];
    }
    {
        OptionStrategyDetailItem *item = [[OptionStrategyDetailItem alloc] init];
        item.SeqNum = 4;
        item.Title = @"预计成交金额：";
        item.Content = [NSString stringWithFormat:@"(%@*%d+手续费%@)*%d手=%@元", [self DoubleRound:leftOrder.OrderPrice + rightOrder.OrderPrice], volumeMultiple, [self DoubleRound:oneFeeLeft + oneFeeRight], orderQty, [self DoubleRound:totalAmount]];
        [itemList addObject:item];
    }
    
    OptionStrategyDetail *detail = [[OptionStrategyDetail alloc] init];
    detail.ProfitPoint = profitPoint;
    detail.Items = itemList;
    return detail;
}
@end
