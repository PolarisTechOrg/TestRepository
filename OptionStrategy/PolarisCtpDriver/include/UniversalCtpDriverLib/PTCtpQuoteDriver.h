//
//  PTCtpQuoteDriver.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTCtpSpiHandlerDelegate.h"
#import "PTFcpInstrument.h"
#import "PTFcpMarketData.h"
#import "PTFcpEnums.h"

@interface PTCtpQuoteDriver : NSObject

@property NSString* brokerId;
@property PTFcpQuoteDriverState driverState;

///注册回调接口, nil 可以清空回调接口。
-(void)RegisterHandler:(id<PTCtpSpiHandlerDelegate>) handler;

- (instancetype)initWithData:(NSString*)appPath brokerId:(NSString*)brokerId  handler:(id<PTCtpSpiHandlerDelegate>)handler;
-(void) CreateApi:(NSString *)pszFlowPath bIsUsingUdp:(BOOL)bIsUsingUdp bIsMulticast:(BOOL)bIsMulticast;
-(PTFcpInstrument*) getInstrumnetByCode:(NSString*) instrumentCode;
-(int) getVolumeMultiple:(NSString*) instrumentCode;
-(void) updateMarketData:(PTFcpMarketData*) marketData;
-(void) Connect:(NSString*) frontIp;
-(void) DisConnect;
-(int) Login:(NSString*) userId password:(NSString*) password;
-(void) Logout ;
-(int) SubscribeMarketData:(NSArray*) instruments ;
-(int) UnSubscribeMarketData:(NSArray*) instruments;


@end
