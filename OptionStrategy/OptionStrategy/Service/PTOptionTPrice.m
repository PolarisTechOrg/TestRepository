//
//  PTOptionTPrice.m
//  OptionStrategy
//
//  Created by admin on 11/26/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "PTOptionTPrice.h"
#import "PTFcpInstrumentDetail.h"
#import "PTStrategyService.h"
#import "PTOptionTPriceItemViewModel.h"
#import "PTFcpOptionDetail.h"
#import "PTOptionTPriceItemViewModel.h"

@interface PTOptionTPrice()

@property NSMutableArray* expireDateArray;
@property NSMutableDictionary* priceDic;     // expireDate => Array (price item)

@end

@implementation PTOptionTPrice

- (instancetype)initWithData:(NSString*)varieties
{
    self = [super init];
    if (self) {
        _varieties = varieties;
        _expireDateArray = [NSMutableArray array];
        _priceDic = [NSMutableDictionary dictionary];
        [self start];
    }
    return self;
}

-(void)start {
    @autoreleasepool {
        NSArray* instruments = [PTStrategyService getOptionInstruments:_varieties];
        for (PTFcpInstrumentDetail* detail in instruments) {
//            NSLog(@"instrument code = %@ ExpireDate = %@", detail.Instrument.instrumentCode, detail.ExpireDate);
            if(![_expireDateArray containsObject:detail.ExpireDate]) {
                [_expireDateArray addObject:detail.ExpireDate]; /// 到期日
            }
            
            //
            PTFcpOptionDetail* option = [[PTFcpOptionDetail alloc] initWithData:detail.Instrument.instrumentCode market:detail.Instrument.market];
//            NSLog(@"strikePrice = %0.4f", option.StrikePrice);
            NSMutableArray* strikeArray = [_priceDic objectForKey:detail.ExpireDate];
            if(strikeArray == nil) {
                strikeArray = [NSMutableArray array];
                [_priceDic setObject:strikeArray forKey:detail.ExpireDate];
            }
            
            PTOptionTPriceItemViewModel* item = [self internalGetPriceItem:strikeArray strikePrice:option.StrikePrice expireDate:detail.ExpireDate];
            if(item == nil) {
                item = [[PTOptionTPriceItemViewModel alloc] init];
                item.strikePrice = option.StrikePrice;
                item.expireDate = detail.ExpireDate;
                [strikeArray addObject:item];
            }
            
            if(option.optionType == PTFcpOptionsTypeCall) {
                item.cInstrumentCode = detail.Instrument.instrumentCode;
            }else if (option.optionType == PTFcpOptionsTypePut) {
                item.pInstrumentCode = detail.Instrument.instrumentCode;
            }
            
        }
//        
//        for (NSDate* date in _expireDateArray) {
//            NSLog(@"date = %@", date);
//        }
//        
//        for (PTOptionTPriceItemViewModel* model in _priceArray) {
//            NSString* c = model.cInstrumentCode;
//            NSString* p = model.pInstrumentCode;
//            if(!c) c = @"";
//            if(!p)p = @"";
//            
//            NSLog(@"strikePrice = %i c = %@ p = %@", model.strikePrice, c, p);
//        }
    }
}

-(NSArray*)getExpireDates {
    return [_expireDateArray copy];
}

-(NSArray*)getItems:(NSDate*)expireDate {
    NSMutableArray* strikeArray = [_priceDic objectForKey:expireDate];
    
    NSArray* items = [strikeArray copy];
    
    return items;
}

-(PTOptionTPriceItemViewModel*)internalGetPriceItem:(NSArray*)items strikePrice:(int)strikePrice expireDate:(NSDate*)expireDate {
    for (PTOptionTPriceItemViewModel* model in items) {
        if(model.strikePrice == strikePrice && [model.expireDate isEqualToDate:expireDate]) {
            return model;
        }
    }
    return nil;
}

@end
