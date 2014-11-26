//
//  PTCtpSpiHandlerDelegate.h
//  testctp02
//
//  Created by admin on 11/14/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "PTMessage.h"

@protocol PTCtpSpiHandlerDelegate

@optional
-(void) handleOrderMessage:(PTMessage*) msg;
-(void) handleQuoteMessage:(PTMessage*) msg;

@end

