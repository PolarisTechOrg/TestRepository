//
//  FAPurchaseDetail.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAPurchaseDetail.h"

@implementation FAPurchaseDetail

-(instancetype)initWithStrategyId:(int) strategyId
{
    self = [super init];
    if(self)
    {
        self.strategyId = strategyId;
    }
    
    return self;
}
@end
