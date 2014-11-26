//
//  PTFcpVarieties.h
//  PolarisCtpDriver
//
//  Created by admin on 11/24/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

@interface PTFcpVarieties : NSObject

@property NSString* Code;
@property NSString* Name;
@property PTFcpProductClass ProductClass;
@property PTFcpMarket market;
@end;
