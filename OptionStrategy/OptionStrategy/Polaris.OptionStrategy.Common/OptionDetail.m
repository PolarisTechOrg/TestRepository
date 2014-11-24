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

-(int)indexOfFirstNumber:(NSString *)origin
{
    NSString *originalString = @"a1b2c3d4e5f6g7h8i9j";
    
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    int number = [numberString intValue];
    
    return number;
}

- (void)ParseCFFEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+'-'+C/P+'-'+执行价格 ,例如：HO1406-C-1450
    
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
