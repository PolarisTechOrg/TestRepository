//
//  FAFillingProfile.m
//  FcpAssistant
//
//  Created by admin on 10/9/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAFillingProfileOperation.h"

@implementation FAFillingProfileOperation

- (id)initWithStrategyIdArray:(NSArray *)idArray
{
    if (self = [super init])
    {
        strategyIdArray = idArray;
    }
    return self;
}

- (void)main
{
    if(strategyIdArray == nil || strategyIdArray.count == 0)
    {
        return;
    }
}

- (NSDictionary *)loadStrategyChartData:(NSArray *)idArray
{
    return nil;
}

- (void)fillingProfile:(NSDictionary *)dataDict
{
    [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
}

@end
