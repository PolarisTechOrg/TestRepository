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
#import "FAStrategyCollectionModel.h"

typedef enum ProfitType
{
    Unknown = 0,
    
    Profit = 1,
    
    Loss = 2,
    
    Balance = 3,
    
}ProfitType;

@interface FAStrategyDetailController : UITableViewController<UIAlertViewDelegate>
{
    NSString *topCellIdentifier;
    NSString *describCellIdentifier;
    NSString *profitCellIdentifier;
    NSString *latedRecordCellIdentifier;
    
    NSString *describHeaderCellIdentifier;
    NSString *profitHeaderCellIdentifier;
    NSString *latedRecordHeaderCellIdentifier;
    
    FAChartDto *profitChartDto;
    FADummieStrategyDetailDto *dataSource;
    FAStrategyCollectionModel *collectionModel;
    
    CGSize descriptionLabelSize;
    UITapGestureRecognizer *doubleClickGR;
}

@property(nonatomic, assign) int strategyId;

@end
