//
//  PTStockQuoteService.h
//  PolarisCtpDriver
//
//  Created by admin on 11/24/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTStockQuoteDelegate.h"

/// 现货指数报价，IO和HO两个品种的期权的标的是现货指数
@interface PTStockQuoteService : NSObject

+(PTStockQuoteService*) shared;
@property id<PTStockQuoteDelegate> handler;
-(void) start ;
-(void) stop;

@end
