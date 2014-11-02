//
//  FAStrategySearchDto.h
//  FcpAssistant
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategySearchDto : NSObject

@property (nonatomic, copy) NSString *SearchText;

@property (nonatomic, retain) NSArray *SearchPriceParten;

@property (nonatomic, retain) NSArray *SearchVarieties;

@property (nonatomic, assign) short OnlineStatus;

@property (nonatomic, assign) int PageSize;

@property (nonatomic, assign) int PageIndex;

@property (nonatomic, assign) int RacerType;


+(id)instance;

@end
