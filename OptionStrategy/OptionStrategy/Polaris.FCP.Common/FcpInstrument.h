//
//  FcpInstrument.h
//  Polaris.FCP.Common
//
//  Created by admin on 11/20/14.
//
//

#import <Foundation/Foundation.h>
#import "FcpMarket.h"

@interface FcpInstrument : NSObject

- (id)Init:(NSString *)code Name:(NSString *)name Market:(FcpMarket)market;


@property (nonatomic, copy) NSString *InstrumentCode;

@property (nonatomic, copy) NSString *InstrumentName;

@property (nonatomic, assign) FcpMarket Market;

@end
