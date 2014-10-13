//
//  FAStrategyDetailController.h
//  FcpAssistant
//
//  Created by admin on 9/23/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FADummieStrategyDetailDto.h"
#import "FAChartDto.h"

@interface FAStrategyDetailController : UITableViewController
{
    NSString *topCellIdentifier;
    NSString *describCellIdentifier;
    NSString *profitCellIdentifier;
    NSString *latedRecordCellIdentifier;
    
    NSString *describHeaderCellIdentifier;
    NSString *profitHeaderCellIdentifier;
    NSString *latedRecordHeaderCellIdentifier;
    
    FADummieStrategyDetailDto *dataSource;
}

//策略ID
@property(nonatomic,assign) int strategyId;
@property(nonatomic, retain) FAChartDto *profitCharDto;

@end
