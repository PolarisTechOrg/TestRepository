//
//  FADummieStrategyDetailDto.m
//  FcpAssistant
//
//  Created by admin on 9/25/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FADummieStrategyDetailDto.h"
#import "FAWinLossViewModel.h"

@implementation FADummieStrategyDetailDto

@synthesize StrategySelection;

@synthesize StrategyDescription;

@synthesize StrategyPerformance;

@synthesize WinLosses;


+(Class)WinLosses_class
{
    return [FAWinLossViewModel class];
}
@end
