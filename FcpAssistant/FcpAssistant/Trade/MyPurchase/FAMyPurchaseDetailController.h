//
//  FAMyPurchaseDetailController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FABuyedStrategyDetailDto.h"

@interface FAMyPurchaseDetailController : UITableViewController
{
    NSString *topCellIdentifier;
    NSString *positionHeaderCellIdentifier;
    NSString *positionCellIdentifier;
    NSString *signalHeaderCellIdentifier;
    NSString *signalCellIdentifier;
    NSString *orderHeaderCellIdentifier;
    NSString *orderCellIdentifier;
    NSString *profitHeaderCellIdentifier;
    NSString *profitCellIdentifier;
    
    FABuyedStrategyDetailDto *dataSource;
}

//组合策略ID
@property(nonatomic,assign) int combineStrategyId;
//策略ID
@property(nonatomic,assign) int strategyId;


@end
