//
//  PTStrategyHeaderDelegate.h
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTStrategyHeaderDelegate

-(void)selectVariety;
-(void)selectStrategy;
-(void)selectLeftExpiredTime;
-(void)selectRightExpiredTime;

@end
