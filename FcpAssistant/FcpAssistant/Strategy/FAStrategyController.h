//
//  FAStrategyController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQueue.h"
#import "FAStrategySearchDto.h"

@interface FAStrategyController : UITableViewController
{
    int currentPageIndex;
    
    NSString *itemCellIdentifier;
    
//    NSMutableArray *dataSource;
    
    FAQueue *dataQueue;
        
    NSMutableDictionary *chartDict;
    
    NSDictionary *perchaseIdDict;
    
    NSDictionary *collectionIdDict;
    
    BOOL hasLoadStrategyIdList;
    
    FAStrategySearchDto *searchDto;
}

@property NSMutableArray *dataSource;

- (void)searchData:(FAStrategySearchDto *)search;

@end
