//
//  FAStrategyProfitDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategyProfitDto : NSObject
// 结算日期。
@property(nonatomic,retain) NSDate *SettlementDate;
// 结算损益。
@property(nonatomic,assign) double Profit;
@end
