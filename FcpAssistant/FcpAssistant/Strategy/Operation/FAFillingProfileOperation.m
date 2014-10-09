//
//  FAFillingProfile.m
//  FcpAssistant
//
//  Created by admin on 10/9/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAFillingProfileOperation.h"
#import "FAStrategyController.h"

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
    
    NSDictionary *dataDict = [self loadStrategyChartData:strategyIdArray];
    
    [self fillingProfile:dataDict];
}

- (NSDictionary *)loadStrategyChartData:(NSArray *)idArray
{
    return nil;
}

- (void)fillingProfile:(NSDictionary *)dataDict
{
    [self performSelectorOnMainThread:@selector(fillStrategyProfit) withObject:nil waitUntilDone:NO];
}

@end
