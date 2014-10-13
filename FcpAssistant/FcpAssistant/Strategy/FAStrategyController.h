//
//  FAStrategyController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQueue.h"

typedef enum ProfitType
{
    Unknown = 0,
    
    Profit = 1,
    
    Loss = 2,
    
    Balance = 3,
    
}ProfitType;

@interface FAStrategyController : UITableViewController
{
    int currentPageIndex;
    
    NSString *itemCellIdentifier;
    
    NSMutableArray *dataSource;
        
    FAQueue *dataQueue;
        
    NSDictionary *chartDic;
}

@end
