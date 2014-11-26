//
//  PTFcpErrorOptions.h
//  OptionStrategy
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int {
    PTFcpErrorNetwork = -1,
    PTFcpErrorMaxPendingRequest = -2,
    PTFcpErrorRequestsPerSecond = -3,
    /// 代表成功；
    PTFcpErrorNoError = 0,
    PTFcpErrorInvalidInstrument = 10000,
} PTFcpErrorOptions;

@interface PTFcpError : NSObject

+(NSString*)getDescription:(PTFcpErrorOptions) error ;

@end
