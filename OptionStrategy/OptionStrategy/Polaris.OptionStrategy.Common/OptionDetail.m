//
//  OptionDetail.m
//  PolarisOptionStrategy
//
//  Created by admin on 11/20/14.
//
//

#import "OptionDetail.h"
#import "FcpMarket.h"

@implementation OptionDetail

@synthesize InstrumentCode;

@synthesize Varieties;

@synthesize Market;

@synthesize OptionMonth;

@synthesize ExchangeOptionMonth;

//@synthesize InstrumentSerial;

@synthesize UnderlyingInstrument;

//@synthesize OptionType;

@synthesize OptionTypeStr;

@synthesize StrikePrice;

- (NSString *)getInstrumentSerial
{
    return [NSString stringWithFormat:@"%@%@", Varieties, OptionMonth];
}

- (FcpOptionsType)getOptionType
{
    if ([[OptionTypeStr uppercaseString] compare:@"C"])
    {
        return FcpOptionsType_Call;
    }
    else if ([[OptionTypeStr uppercaseString] compare:@"P"])
    {
        return FcpOptionsType_Put;
    }
    else
    {
        @throw [NSException exceptionWithName:@"getOptionType" reason:[NSString stringWithFormat:@"Parse optionType failed,invalid optionType:%@", OptionTypeStr] userInfo:nil];
    }
}

#pragma mark - public function
- (OptionDetail *)Init:(FcpInstrument *)instrument
{
    self.InstrumentCode = instrument.InstrumentCode;
    self.Market = instrument.Market;
    
    return self;
}

- (OptionDetail *)Init:(NSString *)instrumentCode Market:(FcpMarket)market
{
    self.InstrumentCode = instrumentCode;
    self.Market = market;
    
    return self;
}

#pragma mark - private function
- (void)Parse:(NSString *)instrumentCode Market:(FcpMarket)fcpMarket
{
    switch (fcpMarket)
    {
        case FcpMarket_CFFE:
            [self ParseCFFEInstrument:instrumentCode];
            break;
            
        case FcpMarket_DCE:
            [self ParseDCEInstrument:instrumentCode];
            break;
            
        case FcpMarket_SFE:
            [self ParseSFEInstrument:instrumentCode];
            break;
        
        case FcpMarket_CZCE:
            [self ParseCZCEInstrument:instrumentCode];
            break;
            
        default:
            break;
    }
}

-(NSUInteger)indexOfFirstNumber:(NSString *)origin
{
    NSString *numberString;
    
    NSScanner *scanner = [NSScanner scannerWithString:origin];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&numberString];
    
    return scanner.scanLocation;
}

- (void)ParseCFFEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+'-'+C/P+'-'+执行价格 ,例如：HO1406-C-1450
    NSArray *codeArray = [instrumentCode componentsSeparatedByString:@"-"];
    
    NSString *varieties;
    NSScanner *scanner = [NSScanner scannerWithString:InstrumentCode];
    
    OptionTypeStr = [codeArray objectAtIndex:1];
    StrikePrice = [[codeArray objectAtIndex:2] intValue];
}

- (void)ParseDCEInstrument:(NSString *)instrumentCode
{
    
}

- (void)ParseSFEInstrument:(NSString *)instrumentCode
{
    
}

- (void)ParseCZCEInstrument:(NSString *)instrumentCode
{
    
}

@end
