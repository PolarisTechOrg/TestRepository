//
//  OptionProfitPoint.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "OptionStrategyType.h"

@interface OptionProfitPoint : NSObject

/// <summary>
/// 策略类型。
/// </summary>
@property (getter = getStrategyType, assign) OptionStrategyType StrategyType;

@end
