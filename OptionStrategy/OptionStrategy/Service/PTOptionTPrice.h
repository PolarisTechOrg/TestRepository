//
//  PTOptionTPrice.h
//  OptionStrategy
//
//  Created by admin on 11/26/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTOptionTPrice : NSObject

@property(readonly) NSString* varieties;


- (instancetype)initWithData:(NSString*)varieties;

-(NSArray*)getExpireDates;
-(NSArray*)getItems:(NSDate*)expireDate;

@end
