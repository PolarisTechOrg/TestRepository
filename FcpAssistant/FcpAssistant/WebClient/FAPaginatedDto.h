//
//  FAPaginatedDto.h
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FADummieStrategyDetailViewModel.h"

// 页面传输类
@interface FAPaginatedDto : NSObject

@property(nonatomic, assign) int PageIndex;

@property(nonatomic, assign) int PageSize;

@property(nonatomic, assign) int TotalCount;

@property(nonatomic, assign) int TotalPageCount;

@property(nonatomic, assign) bool HasNextPage;

@property(nonatomic, assign) bool HasPreviousPage;

@property(nonatomic, retain) NSArray*   Items;

@end
