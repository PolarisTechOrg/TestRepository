//
//  FAStrategySearchDto.m
//  FcpAssistant
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategySearchDto.h"
#import "FAPricePartenDto.h";
#import "FAVarietiesDto.h"

@implementation FAStrategySearchDto

@synthesize  SearchText;

@synthesize SearchPriceParten;

@synthesize SearchVarieties;

@synthesize OnlineStatus;

@synthesize PageSize;

@synthesize PageIndex;

@synthesize RacerType;


+(id)instance
{
    FAStrategySearchDto *dto = [[FAStrategySearchDto alloc] init];
    
    dto.OnlineStatus = 1;
    dto.RacerType = 1;
    dto.PageSize = 10;
    dto.PageIndex = 1;
    
    return dto;
}

+(Class)SearchPriceParten_class
{
    return [FAPricePartenDto class];
}

+(Class)SearchVarieties_class
{
    return [FAVarietiesDto class];
}

@end
