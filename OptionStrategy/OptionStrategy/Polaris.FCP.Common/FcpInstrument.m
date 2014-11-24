//
//  FcpInstrument.m
//  Polaris.FCP.Common
//
//  Created by admin on 11/20/14.
//
//

#import "FcpInstrument.h"

@implementation FcpInstrument

- (id)Init:(NSString *)code Name:(NSString *)name Market:(FcpMarket)market
{
    self.InstrumentCode = code;
    self.InstrumentName = name;
    self.Market = market;
    
    return self;
}


@synthesize InstrumentCode;

@synthesize InstrumentName;

@synthesize Market;

@end
