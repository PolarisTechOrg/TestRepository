//
//  OptionTradeCost.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>

@interface OptionTradeCost : NSObject

/// <summary>
/// 每点价值。
/// </summary>
@property (nonatomic, assign) int VolumeMultiple;

/// <summary>
/// 手续费按费率。
/// </summary>
@property (nonatomic, assign) double FeeByMoney;

/// <summary>
/// 手续费按手数。
/// </summary>
@property (nonatomic, assign) double FeeByVolume;

/// <summary>
/// 期权合约保证金不变部分
/// </summary>
@property (nonatomic, assign) double FixedMargin;

/// <summary>
/// 期权合约最小保证金
/// </summary>
@property (nonatomic, assign) double MiniMargin;


- (OptionTradeCost *)Clone;

@end
