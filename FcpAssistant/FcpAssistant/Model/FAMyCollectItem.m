//
//  FAMyCollectItem.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyCollectItem.h"

@implementation FAMyCollectItem
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
