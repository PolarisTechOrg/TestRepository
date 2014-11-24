//
//  OptionTradeCost.m
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import "OptionTradeCost.h"

@implementation OptionTradeCost

@synthesize VolumeMultiple;

@synthesize FeeByMoney;

@synthesize FeeByVolume;

@synthesize FixedMargin;

@synthesize MiniMargin;


- (OptionTradeCost *)Clone
{
    OptionTradeCost *clone = [[OptionTradeCost alloc] init];
    
    clone.FeeByMoney = self.FeeByMoney;
    clone.FeeByVolume = self.FeeByVolume;
    clone.FixedMargin = self.FixedMargin;
    clone.MiniMargin = self.MiniMargin;
    clone.VolumeMultiple = self.VolumeMultiple;
    
    return clone;
}

@end
