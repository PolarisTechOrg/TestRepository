//
//  OptionIndicator.m
//  OptionStrategy
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "OptionIndicator.h"

@implementation OptionIndicator

- (OptionIndicator *)Init
{
    m_indicatorData = [[OptionIndicatorData alloc] init];
    return self;
}

- (OptionIndicator *)Init:(FcpOptionsType)optionType StrikePrice:(double)strikePrice Ratio:(double)r
{
    if (optionType != FcpOptionsType_Call && optionType != FcpOptionsType_Put)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid option type value." userInfo:nil];
    }
    if (strikePrice <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid strike price value." userInfo:nil];
    }
    if (r <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid risk-free rate value." userInfo:nil];
    }
    
    self.OptionType = optionType;
    self.StrikePrice = strikePrice;
    self.RiskFreeRate = r;
    
    return self;
}

- (OptionIndicator *)Init:(double)volatility OptionType:(FcpOptionsType)optionType StrikePrice:(double)strikePrice Ratio:(double)r
{
    if (volatility <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid volatility value." userInfo:nil];
    }
    if (optionType != FcpOptionsType_Call && optionType != FcpOptionsType_Put)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid option type value." userInfo:nil];
    }
    if (strikePrice <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid strike price value." userInfo:nil];
    }
    if (r <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid risk-free rate value." userInfo:nil];
    }
    
    self.Volatility = volatility;
    self.OptionType = optionType;
    self.StrikePrice = strikePrice;
    self.RiskFreeRate = r;
    
    return self;
}

@synthesize OptionType;

@synthesize StrikePrice;

@synthesize UnderlyingPrice;

@synthesize MaturityTime;

@synthesize RiskFreeRate;

@synthesize Volatility;

@synthesize OptionDelta;

@synthesize OptionGamma;

@synthesize OptionTheta;

@synthesize OptionVega;

@synthesize OptionRho;


- (OptionIndicatorData *)CalcIndicator:(double)volatility OptionType:(FcpOptionsType)optionType StrikePrice:(double)strikePrice UnderlyingPrice:(double)underlyingPrice maturityTime:(double) maturityTime Ratio:(double)r
{
    if (volatility <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid volatility value." userInfo:nil];
    }
    if (optionType != FcpOptionsType_Call && optionType != FcpOptionsType_Put)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid option type value." userInfo:nil];
    }
    if (strikePrice <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid strike price value." userInfo:nil];
    }
    if (underlyingPrice <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid underlying price value." userInfo:nil];
    }
    if (maturityTime <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid maturity time value." userInfo:nil];
    }
    if (r <= 0)
    {
        @throw [NSException exceptionWithName:@"Init" reason:@"Invalid risk-free rate value." userInfo:nil];
    }
    
    return m_indicatorData;
}

- (OptionIndicatorData *)CalcIndicator:(FcpOptionsType)optionType StrikePrice:(double)strikePrice UnderlyingPrice:(double)underlyingPrice MaturityTime:(double)maturityTime Ratio:(double)r Premium:(double)premium
{
    return m_indicatorData;
}

- (OptionIndicatorData *)CalcIndicator:(double)underlyingPrice MaturityTime:(double) maturityTime
{
    return m_indicatorData;
}

- (OptionIndicatorData *)CalcIndicator:(double)underlyingPrice MaturityTime:(double)maturityTime Premium:(double)premium
{
    return m_indicatorData;
}


- (void)UpdateIndicatorData
{
    
}

@end
