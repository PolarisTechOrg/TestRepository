//
//  PTSpiHandler.h
//  testctp02
//
//  Created by admin on 11/14/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTCtpSpiHandlerDelegate.h"

@interface PTSpiHandler : NSObject<PTCtpSpiHandlerDelegate>

-(void) handleOrderMessage:(PTMessage*) msg;
-(void) handleQuoteMessage:(PTMessage*) msg;

@end
