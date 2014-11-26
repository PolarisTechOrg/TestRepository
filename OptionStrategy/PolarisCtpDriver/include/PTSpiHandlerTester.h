//
//  PTSpiHandlerTester.h
//  testctp02
//
//  Created by admin on 11/14/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTCtpSpiHandlerDelegate.h"
#import "PTCtpOrderDriver.h"

@interface PTSpiHandlerTester : NSObject <PTCtpSpiHandlerDelegate>

@property PTCtpOrderDriver *orderDriver;

@end
