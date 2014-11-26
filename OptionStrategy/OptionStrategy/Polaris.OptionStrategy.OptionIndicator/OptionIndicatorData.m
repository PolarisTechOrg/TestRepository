//
//  OptionIndicatorData.m
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "OptionIndicatorData.h"

@implementation OptionIndicatorData

- (OptionIndicatorData *)Init:(double)volatility
{
    self.Volatility = volatility;
    self.Delta = 0;
    self.Gamma = 0;
    self.Theta = 0;
    self.Vega = 0;
    self.Rho = 0;
    
    return self;
}


@synthesize Volatility;

@synthesize Delta;

@synthesize Gamma;

@synthesize Theta;

@synthesize Vega;

@synthesize Rho;


- (BOOL)CheckValidity
{
    if (self.Volatility <= 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
