//
//  FAPaginatedDto.m
//  FcpAssistant
//
//  Created by admin on 9/24/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAPaginatedDto.h"
#import "FADummieStrategyDetailViewModel.h"

@implementation FAPaginatedDto

@synthesize PageIndex;

@synthesize PageSize;

@synthesize TotalCount;

@synthesize TotalPageCount;

@synthesize HasNextPage;

@synthesize HasPreviousPage;

@synthesize Items;


+(Class)Items_class
{
    return [FADummieStrategyDetailViewModel class];
}

@end
