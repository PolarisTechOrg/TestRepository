//
//  FAPaginatedDto.h
//  FcpAssistant
//
//  Created by admin on 9/24/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPaginatedDto : NSObject

@property(nonatomic, assign) int PageIndex;

@property(nonatomic, assign) int PageSize;

@property(nonatomic, assign) int TotalCount;

@property(nonatomic, assign) int TotalPageCount;

@property(nonatomic, assign) bool HasNextPage;

@property(nonatomic, assign) bool HasPreviousPage;

@property(nonatomic, retain) NSArray *Items;


+(Class)Items_class;

@end
