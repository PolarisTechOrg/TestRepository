//
//  PTFcpFundDetail.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFcpFundDetail : NSObject<NSCopying>

/**
 * 投资者帐号
 */
@property NSString* AccountID;

/**
 * 可用金额
 */
@property double Available;

/**
 * 今日入金
 */
@property double Deposit;

/**
 * 质押金额
 */
@property double Mortgage;

/**
 * 上日结存
 */
@property double PreBalance;

/**
 * 上次信用额度
 */
@property double PreCredit;

/**
 * 上次质押金额
 */
@property double PreMortgage;

/**
 * 今日出金
 */
@property double WithDraw;

/**
 * 静态权益
 */
@property double StaticBenefit;

/**
 * 平仓盈亏
 */
@property double CloseProfit;

/**
 * 交易手续费
 */
@property double TradeFee;

/**
 * 持仓盈亏
 */
@property double HoldProfit;

/**
 * 占用保证金
 */
@property double HoldMargin;

/**
 * 动态权益
 */
@property double DynamicBenefit;

/**
 * 冻结保证金
 */
@property double FrozonMargin;

/**
 * 冻结手续费
 */
@property double FrozonFee;

/**
 * 下单冻结
 */
@property double Fronzon;

/**
 * 风险度
 */
@property double Risk;

/**
 * 可取资金
 */
@property double PreferCash;

/**
 * 交割保证金
 */
@property double DeliveryMargin;

@end
