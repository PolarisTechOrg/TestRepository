//
//  PTOptionTPrice.h
//  OptionStrategy
//
//  Created by admin on 11/26/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpMarketData.h"

@interface PTOptionTPrice : NSObject

@property(readonly) NSString* varieties;

 
- (instancetype)initWithData:(NSString*)varieties;

-(NSArray*)getExpireDates;
-(NSArray*)getItems:(NSDate*)expireDate;
/// 订阅行情
-(void)Subscribe:(NSDate*)expireDate;
/// 取消订阅
-(void)Unsubscribe:(NSDate*)expireDate;
/// 更新T型报价，返回更新的行号。
-(int)updateMarketData:(NSDate*)expireDate data:(PTFcpMarketData*) data;

@end
