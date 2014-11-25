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

- (void)ParseCFFEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+'-'+C/P+'-'+执行价格 ,例如：HO1406-C-1450
    NSArray *codeArray = [instrumentCode componentsSeparatedByString:@"-"];
    
    NSString *varieties;
    NSScanner *scanner = [NSScanner scannerWithString:[codeArray objectAtIndex:0]];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&varieties];
    Varieties = varieties;
    
    int month;
    [scanner scanInt:&month];
    OptionMonth = [NSString stringWithFormat:@"%d", month];
    
    ExchangeOptionMonth = OptionMonth;
    
    if ([Varieties isEqualToString:@"HO"] || [Varieties isEqualToString:@"IO"])
    {
        UnderlyingInstrument = Varieties;
    }
    else
    {
        UnderlyingInstrument = [NSString stringWithFormat:@"%@%@", Varieties, OptionMonth];
    }
    
    OptionTypeStr = [codeArray objectAtIndex:1];
    StrikePrice = [[codeArray objectAtIndex:2] intValue];
}

- (void)ParseDCEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+'-'+C/P+'-'+执行价格 ,例如：m1407-C-2850
    
    NSArray *codeArray = [instrumentCode componentsSeparatedByString:@"-"];
    
    NSString *varieties;
    NSScanner *scanner = [NSScanner scannerWithString:[codeArray objectAtIndex:0]];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&varieties];
    Varieties = varieties;
    
    int month;
    [scanner scanInt:&month];
    OptionMonth = [NSString stringWithFormat:@"%d", month];
    
    ExchangeOptionMonth = OptionMonth;
    UnderlyingInstrument = [NSString stringWithFormat:@"%@%@", Varieties, OptionMonth];
    OptionTypeStr = [codeArray objectAtIndex:1];
    StrikePrice = [[codeArray objectAtIndex:2] intValue];
}

- (void)ParseSFEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+C/P+执行价格 ,例如：au1408C230
    NSString *varieties;
    NSScanner *scanner = [NSScanner scannerWithString:instrumentCode];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&varieties];
    Varieties = varieties;
    
    int month;
    [scanner scanInt:&month];
    OptionMonth = [NSString stringWithFormat:@"%d", month];
    
    ExchangeOptionMonth = OptionMonth;
    UnderlyingInstrument = [NSString stringWithFormat:@"%@%@", Varieties, OptionMonth];
    OptionTypeStr = [instrumentCode substringWithRange:NSMakeRange(scanner.scanLocation, 1)];
    StrikePrice = [[instrumentCode substringFromIndex:scanner.scanLocation+1] intValue];
}

- (void)ParseCZCEInstrument:(NSString *)instrumentCode
{
    //产品编码格式:品种+4位月份+C/P+执行价格 ,例如：SR407C3900
    NSString *varieties;
    NSScanner *scanner = [NSScanner scannerWithString:instrumentCode];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&varieties];
    Varieties = varieties;
    
    int month;
    [scanner scanInt:&month];
    NSString *optionMonth = [NSString stringWithFormat:@"%d", month];
    
    ExchangeOptionMonth = optionMonth;
    UnderlyingInstrument = [NSString stringWithFormat:@"%@%@", Varieties, optionMonth];
    
    NSString *yearDecade = [self CurrentYearDecade];
    if ([[optionMonth substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"] && ![[self CurrentYearUnit] isEqualToString:@"0"])
    {
        yearDecade = [NSString stringWithFormat:@"%d", ([yearDecade intValue] + 1)];
    }
    OptionMonth = [NSString stringWithFormat:@"%@%@", yearDecade, optionMonth];
    
    OptionTypeStr = [instrumentCode substringWithRange:NSMakeRange(scanner.scanLocation, 1)];
    StrikePrice = [[instrumentCode substringFromIndex:scanner.scanLocation+1] intValue];
}

- (NSString *)CurrentYearDecade
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:NSDateFormatterShortStyle];
    [formater setDateFormat:@"YYYY-MM-DD HH:mm"];
    
    NSString *current = [formater stringFromDate:[NSDate date]];
    
    return [current substringWithRange:NSMakeRange(2, 1)];
}

- (NSString *)CurrentYearUnit
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:NSDateFormatterShortStyle];
    [formater setDateFormat:@"YYYY-MM-DD HH:mm"];
    
    NSString *current = [formater stringFromDate:[NSDate date]];
    
    return [current substringWithRange:NSMakeRange(3, 1)];
}

@end
