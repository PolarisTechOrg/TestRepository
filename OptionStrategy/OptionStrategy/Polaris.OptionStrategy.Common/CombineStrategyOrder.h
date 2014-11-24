//
//  CombineStrategyOrder.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "StrategyOrder.h"

/// <summary>
/// 组合策略委托单。
/// </summary>
@interface CombineStrategyOrder : NSObject

@property (nonatomic, retain) StrategyOrder *LeftOrder;

@property (nonatomic, retain) StrategyOrder *RightOrder;

@end
