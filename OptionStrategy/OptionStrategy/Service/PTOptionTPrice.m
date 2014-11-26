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
#import "PTCtpQuoteDriver.h"

extern PTCtpQuoteDriver* quoteDriver;

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
        
        /// sort
        [self sortItemDesc];
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

/// 订阅行情
-(void)Subscribe:(NSDate*)expireDate {
    NSMutableArray* strikeArray = [_priceDic objectForKey:expireDate];
    
    NSArray* items = [strikeArray copy];
    NSMutableArray* array = [NSMutableArray array];
    for (PTOptionTPriceItemViewModel* model in items) {
        if(model.cInstrumentCode)[array addObject:model.cInstrumentCode];
        if(model.pInstrumentCode)[array addObject:model.pInstrumentCode];
    }
    [quoteDriver SubscribeMarketData:array];
}

/// 取消订阅
-(void)Unsubscribe:(NSDate*)expireDate {
    NSMutableArray* strikeArray = [_priceDic objectForKey:expireDate];
    
    NSArray* items = [strikeArray copy];
    NSMutableArray* array = [NSMutableArray array];
    for (PTOptionTPriceItemViewModel* model in items) {
        if(model.cInstrumentCode)[array addObject:model.cInstrumentCode];
        if(model.pInstrumentCode)[array addObject:model.pInstrumentCode];
    }
    [quoteDriver UnSubscribeMarketData:array];
}

/// 更新T型报价，返回更新的行号。
-(int)updateMarketData:(NSDate*)expireDate data:(PTFcpMarketData*) data {
    
    @autoreleasepool {
        NSString* instrumentCode = data.Instrument.instrumentCode;
//        PTFcpOptionDetail* option = [[PTFcpOptionDetail alloc] initWithData:instrumentCode market:data.market];
        NSMutableArray* array = [_priceDic objectForKey:expireDate];

            long count = [array count];
            for (int i = 0; i < count; i++) {
                PTOptionTPriceItemViewModel* model = [array objectAtIndex:i];
                if([model.cInstrumentCode isEqualToString:instrumentCode]){
                    model.cBidPrice1 = data.BidPrice1;
                    model.cAskPrice1 = data.AskPrice1;
                    return i;
                } else if ([model.pInstrumentCode isEqualToString:instrumentCode]) {
                    model.pBidPrice1 = data.BidPrice1;
                    model.pAskPrice1 = data.AskPrice1;
                    return i;
                }
            }
    }
    
    return -1;
}

-(void)sortItemDesc {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    
    NSSortDescriptor* sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"strikePrice" ascending:FALSE];
    
    for (NSDate* date in _priceDic) {
        NSMutableArray* array = [_priceDic objectForKey:date];
        if(array == nil) continue;
        NSArray* descriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray* sortedArray = [array sortedArrayUsingDescriptors:descriptors];
        NSMutableArray* items = [NSMutableArray arrayWithArray:sortedArray];
        [dic setObject:items forKey:date];
    }
    
    _priceDic = dic;
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
