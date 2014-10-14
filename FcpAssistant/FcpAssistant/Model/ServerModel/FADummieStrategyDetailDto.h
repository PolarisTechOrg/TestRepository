//
//  FADummieStrategyDetailDto.h
//  FcpAssistant
//
//  Created by admin on 9/25/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FADummieStrategyDetail2ViewModel.h"
#import "FAStrategyDescriptionViewModel.h"
#import "FAStrategyPerformanceViewModel.h"
#import "FAWinLossViewModel.h"

@interface FADummieStrategyDetailDto : NSObject

@property(nonatomic, retain) FADummieStrategyDetail2ViewModel *StrategySelection;

@property(nonatomic, retain) FAStrategyDescriptionViewModel *StrategyDescription;

@property(nonatomic, retain) FAStrategyPerformanceViewModel *StrategyPerformance;

@property(nonatomic, retain) NSArray *WinLosses;


+(Class)WinLosses_class;

@end
