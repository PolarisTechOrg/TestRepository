//
//  FAStrategySignalDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategySignalDto : NSObject
// 信号编号。
@property(nonatomic,assign) int SignalNumber;
// 组合策略ID。
@property(nonatomic,assign) int CombineStragetyID;
// 策略ID。
@property(nonatomic,assign) int StragetyID;
// 信号时间。
@property(nonatomic,copy) NSDate *SignalTime;
// 合约代码。
@property(nonatomic,copy) NSString *InstrumentCode;
// 策略持仓。
@property(nonatomic,assign) int Position;
@end
