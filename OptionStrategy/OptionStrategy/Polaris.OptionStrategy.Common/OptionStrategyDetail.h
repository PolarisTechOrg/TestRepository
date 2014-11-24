//
//  OptionStrategyDetail.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "OptionStrategyDetailItem.h"
#import "OptionProfitPoint.h"

/// <summary>
/// 期权策略明细。
/// </summary>
@interface OptionStrategyDetail : NSObject

/// <summary>
/// 策略损益点。
/// </summary>
@property (nonatomic, retain) OptionProfitPoint *ProfitPoint;

/// <summary>
/// 策略明细条目<OptionStrategyDetailItem>。
/// </summary>
@property (nonatomic, copy) NSArray *Items;

@end
