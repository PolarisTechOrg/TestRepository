//
//  OptionStrategyDetailItem.h
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>

/// <summary>
/// 期权策略明细条目。
/// </summary>
@interface OptionStrategyDetailItem : NSObject

/// <summary>
/// 编号。
/// </summary>
@property (nonatomic, assign) int SeqNum;

/// <summary>
/// 标题。
/// </summary>
@property (nonatomic, copy) NSString *Title;

/// <summary>
/// 内容。
/// </summary>
@property (nonatomic, copy) NSString *Content;

@end
