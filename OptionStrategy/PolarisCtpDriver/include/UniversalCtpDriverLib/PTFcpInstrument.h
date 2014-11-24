//
//  PTFcpInstrument.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

@interface PTFcpInstrument : NSObject<NSCopying>

/**
 * 产品代码。
 * @return
 */
@property NSString* instrumentCode;

/**
 * 产品名称。
 * @return
 */
@property NSString* instrumentName;


@property PTFcpMarket market;


// function
- (instancetype)initWithData:(NSString*)instrumentCode instrumentName:(NSString*) instrumentName market:(PTFcpMarket) market;

-(BOOL) isEqualToFcpInstrument:(PTFcpInstrument*) instrument;
-(NSString*)description;
-(id)copyWithZone:(NSZone *)zone;

@end
