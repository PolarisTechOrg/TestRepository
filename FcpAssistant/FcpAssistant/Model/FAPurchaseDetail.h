//
//  FAPurchaseDetail.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPurchaseDetail : NSObject

@property(nonatomic,assign) int strategyId;
@property (nonatomic,copy) NSString *strategyName;
@property(nonatomic,assign) int orderMultiple;
@property(nonatomic,assign) int todaySignalCount;

-(instancetype)initWithStrategyId:(int) strategyId;


@end
