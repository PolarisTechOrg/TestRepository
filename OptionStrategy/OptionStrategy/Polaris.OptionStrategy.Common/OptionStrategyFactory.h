//
//  OptionStrategyFactory.h
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionStrategyType.h"
#import "OptionStrategy.h"

@interface OptionStrategyFactory : NSObject

+ (OptionStrategy *)Init:(OptionStrategyType)strategyType;

@end
