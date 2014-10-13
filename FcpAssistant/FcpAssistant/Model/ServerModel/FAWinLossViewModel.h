//
//  FAWinLossViewModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-13.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAWinLossViewModel : NSObject
// 盈亏。
@property(nonatomic,assign) double Profit;
// 平仓时间。
@property(nonatomic,retain) NSDate *CloseTime;
@end
