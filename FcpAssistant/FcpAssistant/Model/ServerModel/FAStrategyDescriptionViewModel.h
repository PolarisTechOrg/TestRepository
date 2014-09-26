//
//  FAStrategyDescriptionViewModel.h
//  FcpAssistant
//
//  Created by admin on 9/25/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAStrategyModel.h"


@interface FAStrategyDescriptionViewModel : NSObject

@property(nonatomic, assign) int StrategyId;

@property(nonatomic, copy) NSString *Description;

@property(nonatomic, retain) FAStrategyModel *Strategy;

@end
