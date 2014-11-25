//
//  VarietyViewModel.m
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "VarietyViewModel.h"

@implementation VarietyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Code = @"";
        self.Name = @"";
        self.ExchangeCode = @"";
    }
    return self;
}

- (instancetype)initWithData:(NSString*)code name:(NSString*)name exchangeCode:(NSString*)exchangeCode
{
    self = [super init];
    if (self) {
        self.Code = code;
        self.Name = name;
        self.ExchangeCode = exchangeCode;
    }
    return self;
}

-(NSString*) ExchangeName {
    if ([self.ExchangeCode isEqualToString:@"CFFE"]) {
        return @"中金所";
    } else if ([self.ExchangeCode isEqualToString:@"SFE"]) {
        return @"上期所";
    } else if ([self.ExchangeCode isEqualToString:@"DCE"]) {
        return @"大商所";
    } else if ([self.ExchangeCode isEqualToString:@"CZCE"]) {
        return @"郑商所";
    }
    
    return @"";
}

@end
