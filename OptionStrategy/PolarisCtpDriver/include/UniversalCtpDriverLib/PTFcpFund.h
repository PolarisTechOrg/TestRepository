//
//  PTFcpFund.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFcpFund : NSObject<NSCopying>


/**
 * 账户
 */
@property NSString* AccountID;

/**
 * 上次质押金额
 */
@property double PreMortgage;

/**
 * 上次信用额度
 */
@property double PreCredit;

/**
 * 上次结算准备金(上日结存)
 */
@property double PreBalance;

/**
 * 入金金额
 */
@property double Deposit;

/**
 * 出金金额
 */
@property double WithDraw;

/**
 * 质押金额
 */
@property double Mortgage;

/**
 * 交割保证金
 */
@property double DeliveryMargin;

@end
