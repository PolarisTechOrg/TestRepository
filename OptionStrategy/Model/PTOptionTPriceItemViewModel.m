//
//  PTOptionTPriceItemViewModel.m
//  OptionStrategy
//
//  Created by admin on 11/26/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "PTOptionTPriceItemViewModel.h"

@implementation PTOptionTPriceItemViewModel

-(BOOL)isEqual:(id)object {
    if(object == self) return YES;
    if(!object || ![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToOptionTPriceItem:object];
}

-(BOOL)isEqualToOptionTPriceItem:(PTOptionTPriceItemViewModel*)object {
    if (object == nil) return false;
    
    if(self.strikePrice == object.strikePrice && [self.expireDate isEqualToDate:object.expireDate]) {
        return true;
    }
    return false;
}

@end
