//
//  PTBankRateService.h
//  PolarisCtpDriver
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 一年期银行存款利率
@interface PTBankRateService : NSObject

@property(readonly) double bankRate ;

+(PTBankRateService*) shared ;
-(double) loadBankRate:(NSError**)error ;

@end
