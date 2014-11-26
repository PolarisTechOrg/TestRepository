//
//  PTStockQuoteDelegate.h
//  PolarisCtpDriver
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpMarketData.h"

@protocol PTStockQuoteDelegate <NSObject>

@optional
-(void)handleMarketData:(PTFcpMarketData*) marketData;

@end
